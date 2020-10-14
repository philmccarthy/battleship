require 'minitest/autorun'
require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'
class BoardTest < Minitest::Test
    def setup
        @board = Board.new
        @board.generate
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @cell_1 = @board.cells["A1"] 
        @cell_2 = @board.cells["A2"]
        @cell_3 = @board.cells["A3"]         
    end

    def test_board_exist_and_has_16_cells
        assert_instance_of Board, @board
        assert_equal 16, @board.cells.length
        assert_instance_of Cell, @board.cells["A1"]
    end

    def test_valid_placements_match_by_length
        assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
        assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    end

    def test_valid_placements_cannot_be_nonconsecutive
        assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
        assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
        assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    end

    def test_valid_placements_cannot_be_diagonal
        assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
        assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
        assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    end

    def test_valid_placements_inclusive
        assert @board.valid_placement?(@submarine, ["A1", "A2"])
        assert_equal false, @board.valid_placement?(@submarine, ["A2", "D3"])
        assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
        assert @board.valid_vertical?(@cruiser, ["B1", "C1", "D1"])
    end

    def test_can_place_ship
        @board.place(@cruiser, ["A1", "A2", "A3"])
        assert_instance_of Cell, @board.cells["A1"]  
        assert_instance_of Cell, @board.cells["A2"] 
        assert_instance_of Cell, @board.cells["A3"]
        assert_equal @cruiser, @cell_1.ship
        assert_equal @cruiser, @cell_2.ship
        assert_equal @cruiser, @cell_3.ship
        assert @cell_3.ship == @cell_2.ship
    end

    def test_ships_cannot_overlap
        @board.place(@cruiser, ["A1", "A2", "A3"])
        assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
    end

    def test_board_can_render_cells
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expected = "  1 2 3 4 \n A . . . .  \n B . . . .  \n C . . . .  \n D . . . . "
        assert_equal expected, @board.render

        expected = "  1 2 3 4 \n A S S S .  \n B . . . .  \n C . . . .  \n D . . . . "
        assert_equal expected, @board.render(true)
    end
end
