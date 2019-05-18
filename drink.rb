class Drink

  attr_reader :name, :price
  attr_accessor :count

  def initialize(name, price)
    @name = name
    @price = price
  end

end
