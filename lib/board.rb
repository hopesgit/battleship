require "./lib/ship"
require "./lib/cell"

class Board
  attr_reader :cells, :valid_coordinates

  def initialize
    @cells = generate_cells
    @valid_coordinates = generate_valid_coordinates
  end

  def generate_cells
    cell_hash = {}
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates.each do |coordinate|
      cell_hash[coordinate] = Cell.new(coordinate)
    end
    cell_hash
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def generate_valid_coordinates
    valid_coordinates = Array.new

    @cells.keys.each_slice(4) do |column|
      valid_coordinates.push(column)
    end
    valid_coordinates += valid_coordinates.transpose
  end

  def valid_placement?(ship, coordinates)
    consecutive_check = @valid_coordinates.any? do |set|
      set.each_cons(coordinates.length).any? do |sub_set|
        sub_set == coordinates
      end
    end
    ship.length == coordinates.length && consecutive_check
  end

end
