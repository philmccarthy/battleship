require './lib/cell'
require './lib/ship'
require './lib/board'


def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play or q to quit"
    input = gets.chomp_to_s
    if input == "p"
        start
    elsif input == "q"
        exit
    else 
        puts "Wrong input, please try again."
        #loop back to welcome
    end

    player_board = Board.new
    computer_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    player_board.generate
    computer_board.generate
    computer_board.place(cruiser, ["A4", "B4", "C4"])
    computer_board.place(submarine, ["C2", "C3"])

    #until player_board.cells.any?(obj.ship == cruiser)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts player_board.render
    puts "Enter the coordinates for your Cruiser (3 spaces)"
    cruiser_coordinates = gets.chomp.to_s.upcase.split(" ")
    if player_board.valid_placement?(cruiser, cruiser_coordinates)
        player_board.place(cruiser, cruiser_coordinates)
    else
        puts "Invalid coordinates, please try again."
        #loop back to enter coordinates
    end
    #until player_board.cells.any?(obj.ship == submarine)
    puts player_board.render(true)
    puts "Enter the coordinates for you Submarine (2 spaces)."
    submarine_coordinates = gets.chomp.to_s.upcase.split(" ")
    if player_board.valid_placement?(submarine, submarine_coordinates)
        player_board.place(submarine, submarine_coordinates)
    else
        puts "Invalid coordinates, please try again."
        #loop back to enter coordinates
    end
    
    puts "We are ready to RRRRUUUUMMBBBLLLEEE!"
    puts "COMPUTER BOARD".center(60, "=")
    puts computer_board.render
    puts "PLAYER BOARD".center(60, "=")
    puts player_board.render(true)
    #will have to reuse this step alot
    puts "Enter coordinate to fire"
    pit = gets.chomp.to_s.upcase
    if computer_board.cells.include?(pit)
        computer_board.cells.find {|cell| cell == pit} #fire_upon
    else
        puts "Please enter valid coordinate"
        #loop back to enter coordinate
    end

    #computer fires and loop back to player firing phase
    #until ships are sunk loop this interaction
    #declare victory when all ships are sunk on 1 side
    
    
end

    
