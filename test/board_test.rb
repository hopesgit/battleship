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

  def test_it_can_validate_coordinates
    board = Board.new

    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    refute board.valid_coordinate?("A5")
    refute board.valid_coordinate?("A22")
  end

  def test_rendering_bare_board
    board = Board.new

    assert_equal ". . . .\n. . . .\n. . . .\n. . . .", board.render
  end

  def test_rendering_board_with_misses
    board = Board.new
    board.cells["B4"].fire_upon

    assert_equal ". . . .\n. . . M\n. . . .\n. . . .", board.render
  end
end
