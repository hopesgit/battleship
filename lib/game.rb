require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"

class Game
  attr_reader :player, :cpu, :winner

  def initialize
    @player = Player.new
    @cpu = Player.new
    @winner = nil
  end
end
