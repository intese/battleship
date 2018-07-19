class Ship
  attr_accessor :items
  attr_reader :size, :ship_number

  def initialize(size:, count:)
    @size = size
    @ship_number = "#{size}#{count}"
  end

  def install(x_start:, y_start:, orientation:, ships:)
    self.items  = []
    size.times do |i|
      case orientation
      when Field::ORIENTATION_DOWN
        item = ShipItem.new(x: x_start, y: y_start - i, ship_number: ship_number)
      when Field::ORIENTATION_RIGHT
        item = ShipItem.new(x: x_start + i, y: y_start, ship_number: ship_number)
      end

      if valid?(item) && distance_min(item, ships) > 1
        self.items << item
      else
        return false
      end
    end
    true
  end

  def to_s
    "size: #{size}, items: #{items}"
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

  def ==(item_2)
    items.each do |item_1|
      return ship if item_1 == item_2
    end
    nil
  end

  def try_to_eliminate
    items.each do |item|
      item.status = '$$'
    end if dead?
  end

  def dead?
    items.select{|item| item.status == ' X'}.size == items.size
  end
end
