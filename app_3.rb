# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# noinspection SpellCheckingInspection
puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
puts "What's your Player name"
name = gets.chomp

my_game = Game.new(name)
round = 1
while my_game.still_ongoing?
  puts '=' * 25
  puts "Round #{round}".center(25)
  puts '=' * 25
  round += 1

  my_game.show_player

  my_game.menu
  choice = gets.chomp
  my_game.menu_choice(choice)
  my_game.enemies_attack

end

my_game.end
