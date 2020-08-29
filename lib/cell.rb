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
      ship.hit unless empty?
    else
      "This cell has already been fired upon."
    end
  end

  def render(show = false)
    if fired_upon? == false && empty? == false && show
      "S"
    elsif fired_upon? && empty? == false && ship.health > 0
      "H"
    elsif fired_upon? && empty? == false
      "X"
    elsif fired_upon? && empty?
      "M"
    else
      "."
    end
  end
end
