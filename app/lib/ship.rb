class Ship
  attr_accessor :coordinates
  attr_reader :size

  def initialize(size)
    @size = size
  end

  def install(x_start:, y_start:, orientation:, ships:)
    self.coordinates  = []
    size.times do |i|
      case orientation
      when Field::ORIENTATION_DOWN
        coord = [x_start, y_start - i]
      when Field::ORIENTATION_RIGHT
        coord = [x_start + i, y_start]
      end

      if valid?(coord) && distance_min(coord, ships) > 1
        self.coordinates << coord
      else
        return false
      end
    end
    true
  end

  def to_s
    "size: #{size}, coordinates: #{coordinates}"
  end

  def valid?(coord)
    Field::FIELD_X.include?(coord[0]) && Field::FIELD_Y.include?(coord[1])
  end

  def distance_min(coord1, ships)
    [].tap do |distance|
      distance << 2
      ships.each do |ship|
        ship.coordinates.each do |coord2|
          distance << Math.sqrt((coord1[0] - coord2[0])**2 + (coord1[1] - coord2[1])**2).to_i
        end
      end
    end.min
  end

  def ==(pos)
    coordinates.each do |coord|
      return size if coord == pos
    end
    nil
  end
end
