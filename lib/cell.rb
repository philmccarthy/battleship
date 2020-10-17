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

  def render(fog = false)
    if fog == true && !empty?
      @render = "S"
    elsif empty? && fired_upon?
      @render = "M"
    elsif !empty? && fired_upon? && @ship.sunk?
        @render = "X"
    elsif !empty? && fired_upon? && !@ship.sunk?
        @render = "H"
    else @render
    end
  end


  # def render(fog = false)
  #   if fog == true && !empty?
  #     @render = "S"
  #   elsif empty? && fired_upon?
  #     @render = "M"
  #   elsif !empty? && fired_upon?
  #     if @ship.sunk?
  #       @render = "X"
  #     else
  #       @render = "H"
  #     end
  #   else @render
  #   end
  # end
  #

  def shot_result
    render
    if @render == "M"
      "shot on #@coordinate was a miss."
    elsif @render == "X"
      "shot on #@coordinate sunk a ship!"
    elsif @render == "H"
      "shot on #@coordinate was a hit!"
    end
  end
end
