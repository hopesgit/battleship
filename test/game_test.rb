require "minitest/autorun"
require "minitest/pride"
require "./lib/game"

class GameTest < Minitest::Test

  def test_it_is_game
    player1 = Player.new()
    game = Game.new(player1, player2)

    assert_instance_of Game, game
  end
end
