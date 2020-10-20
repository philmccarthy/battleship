require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

class Game
  attr_reader :player_board,
              :computer_board,
              :player,
              :computer
  # def initialize
  #   setup
  # end

  def setup
    @player = Player.new
    @computer = Player.new
    @player_board = Board.new(@length, @width)
    @player_board.generate
    @computer_board = Board.new(@length, @width)
    @computer_board.generate
    health_check
  end

  def default_ships
    @player.add_ship(@player_cruiser = Ship.new("Cruiser", 3))
    @player.add_ship(@player_submarine = Ship.new("Submarine", 2))
    @computer.add_ship(@computer_cruiser = Ship.new("Cruiser", 3))
    @computer.add_ship(@computer_submarine = Ship.new("Submarine", 2))
    @computer_board.place(@computer_cruiser, @computer.random_coordinates(@computer_board, @computer_cruiser))
    @computer_board.place(@computer_submarine, @computer.random_coordinates(@computer_board, @computer_submarine))
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
        custom_board_query
      elsif input == "q"
        exit
      else
        puts "\n\nWrong input, please try again."
      end
    end
  end

  def custom_board_query
    puts "Would you like to create a custom board y/n?"
    print '> '
    input = ""
    until input == "y" || input == "n" do
      input = gets.chomp.to_s.downcase
    if input == "y"
      create_custom_board
    elsif input == "n"
      @length = 4
      @width = 4  
      setup
      custom_ship_query
    else 
      puts "I don't recognize that input. Try again."
    end
    end
  end

  def create_custom_board
    @length = 0
    @width = 0
    until @length > 3 && @length < 11 do 
      puts "Enter board length between 4 and 10."
      @length = gets.chomp.to_i
      if @length < 4 || @length > 10
        puts "Invalid board length."
      end
    end
      
    until @width > 3 && @width < 11 do 
      puts "Enter board width between 4 and 10."
      @width = gets.chomp.to_i
      if @width < 4 || @width > 10
        puts "Invalid board width."
      end
    end
    setup
    custom_ship_query
  end

  def custom_ship_query
    puts "Enter y to create custom ships or n to play with default ships."
    print '> '
    input = ""
    until input == 'y' || input == 'n' do 
      input = gets.chomp.to_s.downcase
    if input == 'y'
      create_new_ship
    elsif input == 'n'
      default_ships
      play_game
    else 
      puts "I don't recognize that input. Try again."
    end
    end
  end

  def create_new_ship
    until @player.ships.size == 2
      puts "Enter ship name"
      print '> '
      ship_name = gets.chomp.to_s.capitalize
      puts "Enter ship length"
      print '> '
      ship_length = 0
      while ship_length < 2 || ship_length > Math.sqrt(@player_board.cells.length) do
        ship_length = gets.chomp.to_i
        if ship_length < 2 || ship_length > Math.sqrt(@player_board.cells.length)
          puts "Invalid length, try again."
          print '> '
        end
      end
      @player.ships << Ship.new(ship_name, ship_length)
      @computer.ships << Ship.new(ship_name, ship_length)
      @computer_board.place(@computer.ships.last, @computer.random_coordinates(@computer_board, @computer.ships.last))
      if @player.ships.size == 1
        puts "#{ship_name} created!\nCreate your second ship:"
      else
        puts "#{ship_name} created!\n"
      end
    end
    play_game
  end

  def play_game
    puts "PLACE SHIPS".center(60, "=")
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    @player.ships.each { |ship| player_place(ship) }
    firing_phase
  end

  def player_place(ship)
    ship_coordinates = [""]
    until ship_coordinates.all? { |coord| @player_board.valid_coordinate?(coord) } &&
      @player_board.valid_placement?(ship, ship_coordinates) do
        puts
        puts @player_board.render(true)
        puts "\nThe #{@player.ships.first.name} is #{@player.ships.first.length} units long and the #{@player.ships.last.name} is #{@player.ships.last.length} units long."
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
    computer_targets = @player_board.cells.keys
    puts "\nWe are ready to RRRRUUUUMMBBBLLLEEE!\n\n"
    until @player.health == 0 || @computer.health == 0 do
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
      computer_shot = computer_targets.delete(computer_targets.sample)
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
    puts "COMPUTER BOARD".center(60, "=")
    puts @computer_board.render
    puts "PLAYER BOARD".center(60, "=")
    puts @player_board.render(true)
    if @computer.health == 0
      puts
      puts "PLAYER WINS!".center(60, "*")
      puts
    elsif @player.health == 0
      puts
      puts "COMPUTER WINS!".center(60, "*")
      puts
    end
    play_again
  end

  def play_again
    puts "Enter m to return to main menu or q to quit"
    print '> '
    input = gets.chomp.downcase
    if input == 'm'
      # setup
      main_menu
    elsif input == 'q'
      exit
    else "I don't recognize that input. Try again."
    end
  end

  def health_check
    @player.health
    @computer.health
  end

  def computer_count_cells_with_ships
    @computer_board.cells.values.count do |cell|
      !cell.empty?
    end
  end
end
