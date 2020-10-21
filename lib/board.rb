require './lib/create_board'

class Board
  attr_reader :cells
  def initialize(height = 4, width = 4)
    @cells = {}
    @height = height
    @width = width
  end

  def generate
    @board_layout = CreateBoard.new
    array = @board_layout.build_coordinates(@height, @width)
    array.each do |coord|
      @cells[coord] = Cell.new(coord)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_cell_placement?(ship, coordinate)
    @cells[coordinate].ship == nil
  end

  def valid_placement?(ship, coordinates)
    if coordinates.all? { |coord| valid_cell_placement?(ship, coord) }
      valid_length?(ship, coordinates) &&
      (valid_horiz?(ship, coordinates) || valid_vertical?(ship, coordinates))
    else
      false
    end
  end

  def valid_length?(ship, coordinates)
    ship.length == coordinates.count
  end

  def valid_horiz?(ship, coordinates)
    coord_ord = coordinates.map { |coord| coord.ord }
    if coordinates.all? { |coord| coord.ord == coord_ord[0] }
      @cells.keys.each_cons(ship.length).any? { |consec| coordinates == consec }
    else
      false
    end
  end

  def valid_vertical?(ship, coordinates)
    num = coordinates.map { |coord| coord[1] }
    ord = @cells.keys.map { |coord| coord.ord }
    coord_ord = coordinates.map { |coord| coord.ord }
    if coordinates.all? { |coord| coord[1] == num.uniq[0] }
      ord.uniq.each_cons(coordinates.length).any? { |consec| coord_ord == consec }
    else
      false
    end
  end

  def cell_place_ship(ship, coordinate)
    @cells[coordinate].place_ship(ship)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        cell_place_ship(ship, coord)
      end
    end
  end

  def set_fog(fog = false)
    @cells.values.map { |obj| obj.render(fog) }
  end

  def display_row_header(counter)
    rows = @board_layout.build_column(@height)
    rows[counter / @width] + " "
  end

  def render(fog = false)
    if fog == true
      set_fog(true)
    end
    first_row = (1..@width).map { |num| num.to_s + " " }
    display = "  #{first_row.join('')} \n"
    counter = 0
    @cells.keys.each do |coord|
      display += display_row_header(counter) if counter % @width == 0
      counter += 1
      display += "#{@cells[coord].render} "
      display += "\n" if counter % @width == 0
    end
    display
  end
end
