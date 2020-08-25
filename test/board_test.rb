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
end
