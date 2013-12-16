# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Deck.destroy_all
Card.destroy_all

deck = Deck.create
card_values = {
  'A' => 11,
  'K' => 10,
  'Q' => 10,
  'J' => 10
}

['hearts','spades','diamonds','clubs'].each do |suit|
  ((2..10).to_a + ['A','K','Q','J']).each do |rank|
    card_value = (card_values.has_key? rank) ? card_values[rank] : rank
    deck.cards << Card.create(suit: suit, rank: rank, card_value: card_value)
  end
end
