require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'
require './lib/board.rb'
require './lib/player'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @game.length = 4
    @game.width = 4
    @game.setup
    @game.default_ships
  end

  def test_it_exists_and_runs_set_up_method_at_initialize
    assert_instance_of Game, @game
    assert_instance_of Board, @game.player_board
    assert_instance_of Board, @game.computer_board
    assert_equal 5, @game.computer_count_cells_with_ships
  end

  def test_can_check_player_health
    assert_equal 5, @game.health_check
  end

  def test_setup_places_ships_on_cells
    assert_equal 5, @game.computer_count_cells_with_ships
  end
end
