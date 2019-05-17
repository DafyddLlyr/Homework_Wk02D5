require("minitest/autorun")
require("minitest/rg")
require_relative("../guest")
require_relative("../song")
require_relative("../room")

class GuestTest < MiniTest::Test

  def setup
    @song_1 = Song.new("Mmmmm Bop")
    @guest_1 = Guest.new("Freddie", 45, @song_1, 1000)
    @room_1 = Room.new("90s Pop Heaven", 8, 10)
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

  def test_join_room
    @guest_1.join_room(@room_1)
    assert_equal(990, @guest_1.wallet)
  end

end
