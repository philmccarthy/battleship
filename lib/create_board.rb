class CreateBoard
  def build_row(letter, width)
    (1..width).map do |num|
      letter + num.to_s
    end
  end

  def build_column(height)
    array = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
    (1..height).map do |num|
      array[num-1]
    end
  end

  def build_coordinates(height, width)
    board_coordinates = build_column(height).map do |char|
      build_row(char, width)
    end
    board_coordinates.flatten
  end
end
