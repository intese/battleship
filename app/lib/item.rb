class Item
  attr_reader :x, :y, :ship
  attr_accessor :status, :dead

  def initialize(x:, y:, ship:)
    @x, @y, @ship = x, y, ship
    @dead = false
  end

  def to_s
    "x: #{x}, y: #{y}, status: #{status}, ship: #{ship.ship_number}"
  end

  def shoot
    @dead = true
  end
end
