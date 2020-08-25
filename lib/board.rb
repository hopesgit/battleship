require "./lib/ship"
require "./lib/cell"

class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
  end
end
