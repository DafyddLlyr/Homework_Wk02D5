class Bar

  attr_reader :name, :till
  attr_accessor :stock

  def initialize(name, till, stock)
    @name = name
    @till = till
    @stock = stock
  end

  def reduce_stock(drink)
    @stock[drink] -= 1
  end

  def serve?(guest)
    return guest.age >= 18
  end

  def sell_drink(drink, room, guest)
    return if serve?(guest) == false
    reduce_stock(drink)
    room.record_order(drink, guest)
  end

end
