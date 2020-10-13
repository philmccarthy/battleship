class Cell
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
        @render = "."
    end

    def empty?
        @ship.nil?
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        @fired_upon = true
        if !empty?
          @ship.hit
        end
    end

    def render(fog_of_war = false)
      if fog_of_war == true
        @render = "S"
      elsif @ship == nil && @fired_upon == true
        @render = "M"
      elsif !empty? && @fired_upon == true
        if @ship.sunk?
          @render = "X"
        else
          @render = "H"
        end
      else @render
      end
    end
end
