require './lib/ship'
require './lib/board'

class Player
  attr_accessor :name
  attr_reader :cruiser, :submarine, :board

  def initialize
    @name = nil
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

  def pick_random_ship_coordinates(ship)
    board.valid_coordinates.sample.take(ship.length)
  end

  def has_lost?
    @cruiser.sunk? && @submarine.sunk?
  end

  def place_ship(ship, coordinates)
    @board.place(ship, coordinates)
  end

  def receive_fire(coordinate)
    @board.cells[coordinate].fire_upon
  end

end
