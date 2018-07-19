class Field
  attr_accessor :ships, :field_map, :empty_items

  FIELD_X = (1..10)
  FIELD_Y = (1..10)
  ORIENTATION_DOWN = 1
  ORIENTATION_RIGHT = 2

  def setup
    res = false
    begin
      res = attempt_to_setup
    end while !res
    show
  end

  def attempt_to_setup
    self.ships = []
    self.empty_items = []

    { 1 => 5, 2 => 4, 3 => 3, 4 => 2, 5 => 1 }.each_pair do |count, size|
      count.times do |i|
        ship = Ship.new(size: size, count: i+1)
        installed = false
        count_of_tests = 100
        begin
          x,y,o = rand(1..10), rand(1..10), rand(1..2)
          installed = ship.install(x_start: x, y_start: y, orientation: o, ships: ships)
        count_of_tests -= 1
        end while installed == false && count_of_tests > 0

        return false if count_of_tests < 1
        self.ships << ship
      end
    end
    true
  end

  def show
    FIELD_Y.each do |y|
      FIELD_X.each do |x|
        item = find(x,y) || FieldItem.new(x: x, y: y, ship_number: nil)
        print "|#{item.status}"
      end
      print '|'
      puts
    end
    ''
  end

  def shoot(x,y)
    unless item = find(x,y)
      item = FieldItem.new(x: x, y: y, ship_number: nil)
      self.empty_items << item
    end
    item.shoot
    ship = ships.find{|sh| sh.items.include?(item)}
    ship.try_to_eliminate unless ship.nil?
    show
  end

  def find(x,y)
    all_items.find{|item| item.x == x && item.y == y}
  end

  def all_items
    ships.map(&:items).flatten + empty_items
  end
end
