require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'
require './lib/board.rb'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_instance_of Board, @game.player_board
    assert_instance_of Board, @game.computer_board
  end

  def test_health_check_updates_player_and_computer_health
    assert_equal @player_health
  end

end
