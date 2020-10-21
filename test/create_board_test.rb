require 'minitest/autorun'
require 'minitest/pride'
require './lib/create_board'

class CreateBoardTest < Minitest::Test
    def setup
      @new_board = CreateBoard.new
    end

    def test_can_build_row_of_varying_sizes
      expected = %w(A1 A2 A3 A4 A5)
      assert_equal expected, @new_board.build_row("A", 5)
      expected = %w(B1 B2 B3 B4 B5 B6 B7 B8 B9 B10)
      assert_equal expected, @new_board.build_row("B", 10)
    end

    def test_can_build_column_of_varying_sizes
      expected = %w(A B C D E)
      assert_equal expected, @new_board.build_column(5)
      expected = %w(A B C D E F G H I J)
      assert_equal expected, @new_board.build_column(10)
  end

    def test_can_build_coordinates_of_varying_sizes
      expected = %w(A1 A2 A3 B1 B2 B3 C1 C2 C3)
      assert_equal expected, @new_board.build_coordinates(3, 3)
      expected = %w(A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8 C1 C2 C3 C4 C5 C6 C7 C8
                  D1 D2 D3 D4 D5 D6 D7 D8 E1 E2 E3 E4 E5 E6 E7 E8 F1 F2 F3 F4 F5 F6 F7 F8
                  G1 G2 G3 G4 G5 G6 G7 G8 H1 H2 H3 H4 H5 H6 H7 H8)
      assert_equal expected, @new_board.build_coordinates(8, 8)
    end
end
