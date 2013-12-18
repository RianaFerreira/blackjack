(function($){

  $.fn.blackjack = function(){

    function displayStatus(json){

      function displayCards(cards, playerSelector){
        var playerElement = $(playerSelector);
        playerElement.children().remove();
        $(cards).each(function(index, card){
          //playerElement.append($('<li/>').html(card.suit+card.rank));
           var imgUrl = '/assets/'+card.suit+'/'+
             card.rank+card.suit.charAt(0)+'.svg';
          playerElement.append($('<li/>').append($('<img/>').addClass('cards').attr('src',imgUrl)));
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


      displayCards(json.dealer.cards,'#dealer');
      displayCards(json.player.cards, '#player');
      toggleButtons(json);

    };


    var statusURL = $(this).data('status');

    $.getJSON(statusURL, function(json){
      displayStatus(json);
    });


    $('.button.deal, .button.hit, .button.stand').click(function(e){
      var url = $(this).attr('href');
      $.getJSON(url, function(json){
        displayStatus(json);
      });
      e.preventDefault();
      return false;
    });

    return this;
  };

})(jQuery);

$(document).ready(function(){
  $('#blackjack').blackjack();
});