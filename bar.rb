class Bar

  attr_reader :name, :till

  def initialize(name, till, stock)
    @name = name
    @till = till
    @stock = []
  end

  def reduce_stock(drink)
    drink.count -= 1
  end



end
