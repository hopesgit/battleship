require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"

class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @winner = nil
  end
end
