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
  sleep(1)

  my_game.show_player
  sleep(1)
  puts '=' * 25

  my_game.new_players_in_sight
  sleep(1)
  my_game.menu
  print ' > '
  choice = gets.chomp
  puts '=' * 25
  my_game.menu_choice(choice)
  sleep(1)
  puts '=' * 25
  my_game.enemies_attack
  sleep(1)

end

my_game.end
