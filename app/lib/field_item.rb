class FieldItem < Item
  def dead_status
    '.'
  end

  def show_state
    dead ? dead_status : ''
  end
end
