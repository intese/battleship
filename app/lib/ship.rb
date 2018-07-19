class Ship
  attr_accessor :items
  attr_reader :size, :count

  def initialize(size:, count:)
    @size = size
    @count = count
  end

  def install(x_start:, y_start:, orientation:, ships:)
    self.items  = []
    size.times do |i|
      case orientation
      when Field::ORIENTATION_DOWN
        x, y = x_start, y_start - i
      when Field::ORIENTATION_RIGHT
        x, y = x_start + i, y_start
      end

      item = ShipItem.new(x: x, y: y, ship: self)

      if valid?(item) && distance_min(item, ships) > 1
        self.items << item
      else
        return false
      end
    end
    true
  end

  def to_s
    "size: #{size}, items: #{items.join("\n")}"
  end

  def valid?(item)
    Field::FIELD_X.include?(item.x) && Field::FIELD_Y.include?(item.y)
  end

  def distance_min(item_1, ships)
    [].tap do |distance|
      distance << 2
      ships.each do |ship|
        ship.items.each do |item_2|
          distance << Math.sqrt((item_1.x - item_2.x)**2 + (item_1.y - item_2.y)**2).to_i
        end
      end
    end.min
  end

  def dead?
    items.map(&:dead).all?
  end
end
