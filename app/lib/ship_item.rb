class ShipItem < Item
  def dead_status
    'X'
  end

  def show_state
    if dead
      ship.dead? ? '$' : dead_status
    else
      #"%s%s" % [ship.size, ship.count]
      "%s" % ship.size
    end
  end
end
