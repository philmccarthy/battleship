require 'minitest/autorun'
require './lib/board'
require './lib/ship'
require './lib/cell'

class BoardTest < Minitest::Test
    def setup
        @board = Board.new
        @board.generate
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2) 
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
        assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
        # assert_equal true, @board.valid_placement?(@submarine, ["A2", "A3"])

    end
end

