# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new('Josiane')
player2 = Player.new('José')
human = HumanPlayer.new('Human')
round = 1

while player1.life_points.positive? && player2.life_points.positive?
  puts '=' * 25
  puts "Round #{round}".center(25)
  puts '=' * 25
  puts 'States of the players :'
  print player1.show_state
  puts player2.show_state

  player1.attacks(player2)

  break if player1.life_points <= 0

  player2.attacks(player1)
  puts
  round += 1
end

binding.pry
