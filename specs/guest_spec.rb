require("minitest/autorun")
require("minitest/rg")
require_relative("../guest")
require_relative("../song")
require_relative("../room")
require_relative("../bar")
require_relative("../drink")

class GuestTest < MiniTest::Test

  def setup
    @song_1 = Song.new("Mmmmm Bop")
    @song_2 = Song.new("I Want It That Way")
    @guest_1 = Guest.new("Freddie", 45, @song_1, 1000)
    @guest_2 = Guest.new("Michelle", 50, @song_1, 0)
    @room_1 = Room.new("90s Pop Heaven", 8, 10)
    @drink_1 = Drink.new("Beer", 5)
    @drink_2 = Drink.new("Whisky", 10)
    @bar = Bar.new("Dafydd's Karaoke Bar", 100, {@drink_1=>25, @drink_2=>30})
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

  def test_check_favourite_song_in_playlist__yes
    @guest_1.queue_song(@song_1, @room_1)
    @guest_1.queue_song(@song_2, @room_1)
    assert_equal("Woohoo!", @guest_1.check_favourite_song(@room_1))
  end

  def test_check_favourite_song_in_playlist__no
    @guest_1.queue_song(@song_2, @room_1)
    @guest_1.queue_song(@song_2, @room_1)
    assert_nil(@guest_1.check_favourite_song(@room_1))
  end

  def test_buy_drink__money
    @guest_1.buy_drink(@drink_1, @bar, @room_1)
    assert_equal(995, @guest_1.wallet)
  end

  def test_buy_drink__no_money
    @guest_2.buy_drink(@drink_1, @bar, @room_1)
    assert_equal(0, @guest_2.wallet)
  end

end
