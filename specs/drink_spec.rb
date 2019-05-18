require("minitest/autorun")
require("minitest/rg")
require_relative("../drink")

class TestDrink < MiniTest::Test

  def setup
    @drink_1 = Drink.new("Innis & Gunn", 5)
  end

  def test_drink_name
    assert_equal("Innis & Gunn", @drink_1.name)
  end

  def test_drink_price
    assert_equal(5, @drink_1.price)
  end

end
