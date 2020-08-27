require './lib/ship'
require './lib/board'

class Player
  attr_reader :cruiser, :submarine
  attr_accessor :board

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

end
