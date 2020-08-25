require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @fired_upon == false
      @fired_upon = true
      ship.hit if empty? == false
    else
      "This cell has already been fired upon."
    end
  end

  def render(show = false)
    if @fired_upon == false && empty? == false && show == true
      "S"
    elsif @fired_upon == true && empty? == false && ship.health > 0
      "H"
    elsif @fired_upon == true && empty? == false && ship.health == 0
      "X"
    elsif @fired_upon == true && empty? == true
      "M"
    else
      "."
    end
  end
end
