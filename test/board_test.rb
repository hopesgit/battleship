require "minitest/autorun"
require "minitest/pride"
require "./lib/board"

class BoardTest < Minitest::Test

  def test_it_is_a_board
    board = Board.new

    assert_instance_of Board, board
  end
end
