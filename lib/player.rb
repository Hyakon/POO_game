# frozen_string_literal: true

# Player class
class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} have #{@life_points} health"
  end

  def gets_damage(damage)
    @life_points -= damage
    puts "Player #{@name} has been killed" if @life_points < 1
  end

  def compute_damage
    rand(1..6)
  end

  def attacks(target)
    puts "Player #{@name} attacks player #{target.name}"
    power = compute_damage
    target.gets_damage(power)
    puts "He hit him for #{power} damage"
  end
end

# Human is a race of Player Class
class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} has #{@life_points} health and has a level #{@weapon_level} weapon"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon = rand(1..6)
    puts "You find a level #{new_weapon} weapon"
    if new_weapon > @weapon_level
      @weapon_level = new_weapon
      puts 'Yay, you found a better weapon, you keep it'
    else
      puts 'F@*#$, it\'s not a better weapon'
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts 'You found nothing'
    elsif dice.between?(2, 5)
      puts 'You found +50 life points pack'
      @life_points += 50
    else
      puts 'Amazing ! You found +80 life points pack'
      @life_points += 80
    end
    @life_points = 100 if life_points > 100
  end
end
