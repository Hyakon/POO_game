# frozen_string_literal: true

# Game Class
class Game
  attr_accessor :human_player, :enemies

  def initialize(name)
    @enemies = []
    @human_player = HumanPlayer.new(name)
    4.times do |i|
      @enemies << Player.new("player#{i + 1}")
    end
  end

  def kill_player(player)
    @enemies.delete(player)
  end

  # @return [TrueClass, FalseClass]
  def still_ongoing?
    @human_player.life_points.positive? && !@enemies.empty?
  end

  def show_player
    puts human_player.show_state
    puts "Enemies left : #{@enemies.size}"
  end

  def menu
    # noinspection SpellCheckingInspection
    puts "\nQuelle action veux-tu effectuer ?

  a - chercher une meilleure arme
  s - chercher à se soigner

attaquer un joueur en vue :"
    @enemies.size.times do |i|
      print "   #{i} - "
      print enemies[i].show_state
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
    @enemies.each { |enemy| sleep(1); enemy.attacks(@human_player) }
  end

  def end
    if @human_player.life_points.positive?
      puts 'You Win'
    else
      puts 'You loose'
    end
  end

  private

  def perf_menu
    puts 'Do something in menu'
    sleep(2)
    menu
    menu_choice(gets.chomp)
  end
  def menu_choice_bis(choice)
    player = enemies[choice.to_i]
    @human_player.attacks(player)
    kill_player(player) unless player.life_points.positive?
  end
end
