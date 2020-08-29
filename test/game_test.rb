require "minitest/autorun"
require "minitest/pride"
require "./lib/game"

class GameTest < Minitest::Test

  def test_it_is_game
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    game = Game.new

    assert_instance_of Player, game.player
    assert_instance_of Player, game.cpu
    assert_nil game.winner
  end
end
