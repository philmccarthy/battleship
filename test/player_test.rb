require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/board'
require './lib/ship'
require './lib/cell'

class PlayerTest < Minitest::Test
  def setup
    @computer = Player.new
    @human = Player.new
    @board = Board.new
    @board.generate
    @computer.add_board(@board)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Player, @computer
    assert_instance_of Player, @human
    assert_equal [], @human.ships
  end

  def test_can_add_board
    assert_instance_of Board, @human.add_board(@board)
  end

  def test_player_can_add_ship
    @human.add_ship(@cruiser)
    assert_equal [@cruiser], @human.ships
  end

  def test_player_can_place_ships_randomly
    expected = [ 
    ["A1", "A2", "A3"],
    ["A2", "A3", "A4"],
    ["A3", "A4", "B1"],
    ["A4", "B1", "B2"],
    ["B1", "B2", "B3"],
    ["B2", "B3", "B4"],
    ["B3", "B4", "C1"],
    ["B4", "C1", "C2"],
    ["C1", "C2", "C3"],
    ["C2", "C3", "C4"],
    ["C3", "C4", "D1"],
    ["C4", "D1", "D2"],
    ["D1", "D2", "D3"],
    ["D2", "D3", "D4"],
    ["A1", "B1", "C1"],
    ["B1", "C1", "D1"],
    ["C1", "D1", "A2"],
    ["D1", "A2", "B2"],
    ["A2", "B2", "C2"],
    ["B2", "C2", "D2"],
    ["C2", "D2", "A3"],
    ["D2", "A3", "B3"],
    ["A3", "B3", "C3"],
    ["B3", "C3", "D3"],
    ["C3", "D3", "A4"],
    ["D3", "A4", "B4"],
    ["A4", "B4", "C4"],
    ["B4", "C4", "D4"]
    ]

    assert_includes expected, @computer.random_coordinates(@cruiser)
  end
end
