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
    computer_selection = @board.valid_coordinates.sample.take(ship.length)
    if computer_coordinates_empty?(computer_selection)
      computer_selection
    else
      pick_random_ship_coordinates(ship)
    end
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

  def computer_coordinates_empty?(computer_selection)
    computer_selection.all? do |cell|
      @board.cells[cell].empty?
    end
  end

end
