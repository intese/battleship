class Item
  attr_reader :x, :y, :ship_number
  attr_accessor :status

  def initialize(x:, y:, ship_number:)
    @x, @y, @ship, @status = x, y, ship_number, ship_number
    @status = '  ' if ship_number.nil?
  end

  def to_s
    "x: #{x}, y: #{y}, status: #{status}, ship_number: #{ship_number}"
  end
end
