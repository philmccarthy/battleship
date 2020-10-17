require './lib/cell.rb'
require './lib/ship.rb'
require './lib/board.rb'

class Game
  attr_reader :player_board,
              :computer_board

  def health_check
    @player_health = [@player_cruiser, @player_submarine].sum { |ship| ship.health }
    @computer_health = [@computer_cruiser, @computer_submarine].sum { |ship| ship.health }
  end

  def computer_place(ship)
    coordinates = []
    @computer_board.cells.keys.each_cons(ship.length) {|cons_keys| coordinates << cons_keys}
    computer_selection = coordinates.sample
    until @computer_board.valid_placement?(ship, computer_selection)
      computer_selection = coordinates.sample
    end
    @computer_board.place(ship, computer_selection)
  end

  def setup
    @player_board = Board.new
    @player_board.generate
    @computer_board = Board.new
    @computer_board.generate
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    health_check
    computer_place(@computer_cruiser)
    computer_place(@computer_submarine)
  end

  def main_menu
    puts "\n"
    puts "Welcome to BATTLESHIP".center(60, "=")
    input = ""
    until input == "p" do
      puts "\nEnter p to play or q to quit"
      print '> '
      input = gets.chomp.to_s.downcase
      if input == "p"
        play_game
      elsif input == "q"
        exit
      else
        puts "\n\nWrong input, please try again."
      end
    end
  end

  def play_game
    setup
    @computer_targets = @player_board.cells.keys
    puts "PLACE SHIPS".center(60, "=")
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    player_place(@player_cruiser)
    player_place(@player_submarine)
    firing_phase
  end

  def player_place(ship)
    ship_coordinates = [""]
    until ship_coordinates.all? { |coord| @player_board.valid_coordinate?(coord) } &&
      @player_board.valid_placement?(ship, ship_coordinates) do
        puts
        puts @player_board.render(true)
        puts "\nThe Cruiser is three units long and the Submarine is two units long."
        puts "Enter the squares for your #{ship.name} (#{ship.length} spaces)"
        print '> '
        ship_coordinates = gets.chomp.to_s.upcase.split(" ")
        if !ship_coordinates.all? { |coord| @player_board.valid_coordinate?(coord) }
          puts
          puts "What board are you playing on?".center(60, "=")
        elsif !@player_board.valid_placement?(ship, ship_coordinates)
          puts
          puts "Invalid coordinates, please try again.".center(60, "=")
        end
      end
      @player_board.place(ship, ship_coordinates)
    end

    def firing_phase
    puts "\nWe are ready to RRRRUUUUMMBBBLLLEEE!\n\n"
    until @player_health == 0 || @computer_health == 0 do
      puts "COMPUTER BOARD".center(60, "=")
      puts @computer_board.render
      puts "PLAYER BOARD".center(60, "=")
      puts @player_board.render(true)
      puts "\nEnter the coordinate for your shot:"
      print '> '
      player_target = gets.chomp.to_s.upcase
      if !@computer_board.valid_coordinate?(player_target)
        puts
        puts "Invalid coordinate. What board are you playing on?".center(60, "=")
        puts
        next
      elsif @computer_board.cells[player_target].render != '.'
        puts
        puts "Ha! You already fired there.".center(60, "=")
        puts
      elsif
        @computer_board.cells.include?(player_target)
        @computer_board.cells[player_target].fire_upon
        puts "\nYour #{@computer_board.cells[player_target].shot_result}"
      else
        puts
        puts "Please enter valid coordinate:".center(60, "=")
        puts
      end
      computer_shot = @computer_targets.delete(@computer_targets.sample)
      if @player_board.cells.include?(computer_shot)
        @player_board.cells[computer_shot].fire_upon
        puts "My #{@player_board.cells[computer_shot].shot_result}\n"
        puts
      end
      health_check
    end
    game_over
  end

  def game_over
    if @computer_health == 0
      puts "PLAYER WINS!".center(60, "=")
    elsif @player_health == 0
      puts "COMPUTER WINS!".center(60, "=")
    end
    play_again
  end

  def play_again
    puts "Enter m to return to main menu or q to quit"
    print '> '
    input = gets.chomp.downcase
    if input == 'm'
      start  #
    elsif input == 'q'
      exit
    else "I don't recognize that input. Try again."
    end
  end
end
