require("minitest/autorun")
require("minitest/rg")
require_relative("../bar")
require_relative("../drink")

class TestBar < MiniTest::Test

  def setup
    @drink_1 = Drink.new("Beer", 5)
    @drink_2 = Drink.new("Whisky", 10)
    @bar = Bar.new("Dafydd's Karaoke Bar", 100, {@drink_1: 25, @drink_2: 30})
  end

  def test_bar_name
    assert_equal("Dafydd's Karaoke Bar", @bar.name)
  end

  def test_bar_till
    assert_equal(100, @bar.till)
  end

  def test_reduce_stock
    @bar.reduce_stock(@drink_1)
    assert_equal(24, @drink_1.count)
  end

end
