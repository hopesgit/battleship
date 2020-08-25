require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

  def render(show = false)
    if fired_upon == false && empty? == false && show == true
      "S"
    elsif fired_upon == false && show == false
      "."
    elsif fired_upon == true && empty? == false && ship.health > 0
      "H"
    elsif fired_upon == true && empty? == false && ship.health = 0
      "X"
    elsif fired_upon == true && empty? == true
      "M"
    end
  end

end
