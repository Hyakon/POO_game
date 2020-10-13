# frozen_string_literal: true

# Game Class
class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @enemies_in_sight = []
    @players_left = 10
    @human_player = HumanPlayer.new(name)
    4.times do |i|
      @enemies_in_sight << Player.new("player_#{i + 1}")
    end
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
    @players_left -= 1
  end

  # @return [TrueClass, FalseClass]
  #
  def still_ongoing?
    @human_player.life_points.positive? && @players_left.positive?
  end

  def show_player
    puts human_player.show_state
    puts "Enemies left : #{@enemies_in_sight.size}"
  end

  def new_players_in_sight
    dice = rand(1..6)
    if players_left <= enemies_in_sight.size
      puts 'All players are in sight'
    elsif dice == 1
      puts 'Incoming players none'
    elsif dice.between?(2, 4)
      new_player(1)
    else
      new_player(2)
    end
  end

  def menu
    # noinspection SpellCheckingInspection
    puts "\nQuelle action veux-tu effectuer ?

  a - chercher une meilleure arme
  s - chercher à se soigner


attaquer un joueur en vue :"
    @enemies_in_sight.size.times do |i|
      print "   #{i} - "
      print enemies_in_sight[i].show_state
    end
  end

  def menu_choice(choice)
    case choice
    when 'a'
      @human_player.search_weapon
    when 's'
      @human_player.search_health_pack
    when /^[0-9]/
      menu_choice_bis(choice)
    else
      perf_menu
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      sleep(0.5)
      enemy.attacks(@human_player)
    end
  end

  def end
    if @human_player.life_points.positive?
      puts 'You Win'
    else
      puts 'You loose'
    end
  end

  private

  def new_player(new)
    puts 'One player incoming' if new == 1
    puts 'Two player incoming' if new == 2

    new.times do
      player = Player.new('player_' + rand(5..9999).to_s)
      @enemies_in_sight << player
      player.show_state
    end
  end

  def perf_menu
    puts 'Do something in menu'
    sleep(2)
    menu
    menu_choice(gets.chomp)
  end

  def menu_choice_bis(choice)
    player = enemies_in_sight[choice.to_i]
    @human_player.attacks(player)
    kill_player(player) unless player.life_points.positive?
  end
end
