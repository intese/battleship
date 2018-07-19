class Field
  attr_accessor :ships, :field_map

  FIELD_X = (1..10)
  FIELD_Y = (1..10)
  ORIENTATION_DOWN = 1
  ORIENTATION_RIGHT = 2

  def setup
    res = false
    begin
      res = attempt_to_setup
    end while !res
    save
    show
  end

  def attempt_to_setup
    self.ships = []

    { 1 => 5, 2 => 4, 3 => 3, 4 => 2, 5 => 1 }.each_pair do |count, size|
      count.times do
        ship = Ship.new(size)
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

  def save
    self.field_map = [].tap do |arr|
      FIELD_Y.each do |y|
        FIELD_X.each do |x|
          res = ships.find{|ship| ship == [x,y]}
          sym = res ? "#{res.size}" : ' '
          arr << {x: x, y: y, sym: sym}
        end
      end
    end
  end

  def show
    FIELD_Y.each do |y|
      FIELD_X.each do |x|
        cell = find(x,y)
        print "| #{cell[:sym]}"
      end
      print '|'
      puts
    end
    ''
  end

  def shoot(x,y)
    cell = find(x,y)
    cell[:sym] = cell[:sym].to_i > 0 ? 'X' : '.'
    show
  end

  def find(x,y)
    field_map.find{|hsh| hsh[:x] == y && hsh[:y] == y}
  end
end
