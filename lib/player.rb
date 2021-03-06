class Player
  attr_reader :ships, :health
  def initialize
    @ships = []
  end

  def health
    @health = @ships.sum { |ship| ship.health }
  end

  def add_ship(ship)
    @ships << ship
  end

  def random_coordinates(board, ship)
    coordinates = []
    board.cells.keys.each_cons(ship.length) { |cons_keys| coordinates << cons_keys }
    columns = board.cells.keys.map {| coord| coord.delete(coord[0]) }.uniq
    vert_choices = columns.map do |col|
      board.cells.keys.select { |coord| coord.delete(coord[0]) == col }
    end
    vert_choices.flatten.each_cons(ship.length) { |cons_vert| coordinates << cons_vert }
    computer_selection = coordinates.sample
    until board.valid_placement?(ship, computer_selection)
      computer_selection = coordinates.sample
    end
    computer_selection
  end
end
