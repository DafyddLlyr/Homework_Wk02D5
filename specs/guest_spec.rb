require("minitest/autorun")
require("minitest/rg")
require_relative("../guest")
require_relative("../song")

class GuestTest < MiniTest::Test

  def setup
    @song_1 = Song.new("Somebody to Love")
    @guest_1 = Guest.new("Freddie", 45, @song_1, 1000)
  end

  def test_guest_name
    assert_equal("Freddie", @guest_1.name)
  end

  def test_guest_age
    assert_equal(45, @guest_1.age)
  end

  def test_guest_favourite_song
    assert_equal(@song_1, @guest_1.favourite_song)
  end

  def test_guest_wallet
    assert_equal(1000, @guest_1.wallet)
  end

end
