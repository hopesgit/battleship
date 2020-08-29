require "minitest/autorun"
require "minitest/pride"
require "./lib/board"

class BoardTest < Minitest::Test

  def test_it_is_a_board
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_holds_cells
    board = Board.new

    assert_equal 16, board.cells.keys.count
    assert_equal 16, board.cells.values.count
    assert_instance_of Cell, board.cells["D4"]
  end

  def test_it_can_generate_cells_based_on_board_dimensions
    board = Board.new
    board2 = Board.new(5,5)

    assert_equal 16, board.cells.keys.count
    assert_equal 25, board2.cells.keys.count
  end

  def test_it_can_validate_coordinates
    board = Board.new

    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    refute board.valid_coordinate?("A5")
    refute board.valid_coordinate?("A22")
  end

  def test_it_can_validate_non_standard_dimensions
    board = Board.new(7,7)

    assert board.valid_coordinate?("A4")
    assert board.valid_coordinate?("A7")
    assert_equal false, board.valid_coordinate?("A22")
    assert board.valid_coordinate?("G7")
  end

  def test_it_has_valid_placement_method
    board = Board.new

    assert board.respond_to?(:valid_placement?)
  end

  def test_it_can_validate_placement_by_length
    board = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_nonconsecutive_coordinates_are_invalid
    board = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_diagonal_coordinates_are_invalid
    board = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_valid_coordinates
    board = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement?(submarine, ["C1", "C2"])
    assert board.valid_placement?(submarine, ["B1", "C1"])
    assert board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_ships_can_be_placed
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal cruiser, board.cells["A1"].ship
    assert_equal cruiser, board.cells["A2"].ship
    assert_equal cruiser, board.cells["A3"].ship
  end

  def test_rendering_bare_board
    board = Board.new

    assert_equal "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .", board.render
  end

  def test_rendering_board_with_misses
    board = Board.new
    board.cells["B4"].fire_upon

    assert_equal "  1 2 3 4\nA . . . .\nB . . . M\nC . . . .\nD . . . .", board.render
  end

  def test_render_with_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C3", "D3"])

    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon
    board.cells["C2"].fire_upon
    board.cells["D3"].fire_upon

    assert_equal "  1 2 3 4\nA X X X .\nB . . . .\nC . M . .\nD . . H .", board.render
    assert_equal "  1 2 3 4\nA X X X .\nB . . . .\nC . M S .\nD . . H .", board.render(true)
  end
end
