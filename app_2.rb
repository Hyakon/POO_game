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

player1 = Player.new('Josiane')
player2 = Player.new('Josy')
enemies = [player1, player2]
human = HumanPlayer.new(name)
round = 1

while human.life_points.positive? && (enemies[0].life_points.positive? || enemies[1].life_points.positive?)
  puts '=' * 25
  puts "Round #{round}".center(25)
  puts '=' * 25
  puts 'States of the players :'
  puts human.show_state

  # noinspection SpellCheckingInspection
  print "\nQuelle action veux-tu effectuer ?

  a - chercher une meilleure arme
  s - chercher à se soigner

attaquer un joueur en vue :
  0 - "
  puts enemies[0].show_state
  print '  1 - '
  puts enemies[1].show_state

  choice = gets.chomp
  case choice
  when 'a'
    human.search_weapon
  when 's'
    human.search_health_pack
  when '0'
    human.attacks(enemies[choice.to_i])
  when '1'
    human.attacks(enemies[choice.to_i])
  else
    puts 'try again'
  end

  puts 'Enemies fight back !!'

  enemies.each do |enemy|
    enemy.attacks(human) if enemy.life_points.positive?
  end
  round += 1
end

if human.life_points.positive?
  puts 'You Win'
else
  puts 'You loose'
end
