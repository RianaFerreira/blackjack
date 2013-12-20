(function($){
  // jQuery Plugin
  $.fn.blackjack = function(){

    function displayStatus(json){

      function displayCards(cards, playerSelector){
        // clear the card list items for the player and dealer
        var playerElement = $(playerSelector);
        playerElement.children().remove();

        // each list item has an image element with the class cards
        $(cards).each(function(index, card){
          // playerElement.append($('<li/>').html(card.suit+card.rank));
           var imgUrl = 'url(/assets/'+card.suit+'/'+
             card.rank+card.suit.charAt(0)+'.svg)';
          // playerElement.append($('<li/>').append($('<img/>').addClass('cards').attr('src',imgUrl)));
          playerElement.append($('<div/>').addClass('cards').css('background-image',imgUrl));
        });
      };

      function toggleButtons(json){
        $('#status').html(json.status);

        if(json.status == 'pending'){
          $('.button.deal').addClass('disabled');
          $('.button.hit, .button.stand').removeClass('disabled');
        } else {
          $('.button.deal').removeClass('disabled');
          $('.button.hit, .button.stand').addClass('disabled');
        }

      };

      function updateStats(json){
        $('#win_stats').html(json.player.win);
        $('#lost_stats').html(json.player.lost);
        $('#draw_stats').html(json.player.draw);
      };


      displayCards(json.dealer.cards,'#dealer');
      displayCards(json.player.cards, '#player');
      toggleButtons(json);
      updateStats(json);

    };

    var statusURL = $(this).data('status');
    $.getJSON(statusURL, function(json){
      displayStatus(json);
    });

    $('.button.deal, .button.hit, .button.stand').click(function(e){
      e.preventDefault();
      if ($(this).hasClass('disabled')) {
        return; // Button is disabled so do nothing.
      }
      var url = $(this).attr('href');
      $.getJSON(url, function(json){
        displayStatus(json);
      });

      return false;
    });

    return this;
  };

})(jQuery);

$(document).ready(function(){
  $('#blackjack').blackjack();
});