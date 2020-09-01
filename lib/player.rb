require './lib/ship'
require './lib/board'

class Player
  attr_accessor :name, :board
  attr_reader :cruiser, :submarine

  def initialize(board = Board.new(4,4))
    @name = "General"
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = board
  end

  def pick_random_ship_coordinates(ship)
    computer_sample_set = @board.valid_coordinates.sample
    computer_sample_placement = computer_sample_set.take(ship.length)
    if validate_random_coordinate_length(computer_sample_set, ship) && computer_coordinates_empty?(computer_sample_placement)
      computer_sample_placement
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

  def computer_coordinates_empty?(computer_sample_placement)
    computer_sample_placement.all? do |cell|
      @board.cells[cell].empty?
    end
  end

  def validate_random_coordinate_length(sample, ship)
    sample.length >= ship.length
  end

  def find_cells_containing_ship(ship)
    ship_containing_cells = board.cells.values.find_all do |cell|
      cell.ship == ship
    end
    ship_containing_cells.map { |cell| cell.coordinate }
  end
end
