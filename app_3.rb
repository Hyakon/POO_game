# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

g = Game.new('name')

g.human_player.show_state
g.enemies.each do |enemy|
  enemy.show_state
end

binding.pry