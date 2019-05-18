require("minitest/autorun")
require("minitest/rg")
require_relative("../room")
require_relative("../guest")
require_relative("../song")
require_relative("../drink")
require_relative("../bar")

class RoomTest < MiniTest::Test

  def setup
    @room_1 = Room.new("80s Party Room", 8, 10)
    @room_2 = Room.new("60s Pop", 2, 10)

    @song_1 = Song.new("Life on Mars")
    @song_2 = Song.new("Rocketman")
    @song_3 = Song.new("In The Air Tonight")

    @guest_1 = Guest.new("David", 30, @song_1, 100)
    @guest_2 = Guest.new("Eve", 35, @song_1, 100)
    @guest_3 = Guest.new("Carol", 36, @song_1, 100)

    @drink_1 = Drink.new("Beer", 5)
    @drink_2 = Drink.new("Whisky", 10)
    
    @bar = Bar.new("Dafydd's Karaoke Bar", 100, {@drink_1=>25, @drink_2=>30})
  end

  def test_room_name
    assert_equal("80s Party Room", @room_1.name)
  end

  def test_room_capacity
    assert_equal(8, @room_1.capacity)
  end

  def test_room_entry_fee
    assert_equal(10, @room_1.entry_fee)
  end

  def test_guests
    assert_equal([], @room_1.guests)
  end

  def test_gross
    assert_equal(0, @room_1.gross)
  end

  def test_history
    assert_equal([], @room_1.history)
  end

  def test_playlist__inital_state
    assert_equal([], @room_1.playlist)
  end

  def test_current_song__inital_state
    assert_nil(@room_1.current_song)
  end

  def test_current_song__two_songs
    @room_1.play_song(@song_1)
    @room_1.play_song(@song_2)
    assert_equal(@song_2, @room_1.current_song)
    assert_equal(2, @room_1.playlist.length)
  end

  def test_play_song
    @room_1.play_song(@song_1)
    assert_equal(@song_1, @room_1.current_song)
  end

  def test_queue_song
    @room_1.play_song(@song_1)
    @room_1.queue_song(@song_2)
    @room_1.queue_song(@song_3)
    assert_equal(@song_1, @room_1.current_song)
    assert_equal(3, @room_1.playlist.length)
    assert_equal(@song_3, @room_1.playlist.last)
  end

  def test_skip_song__default_skip
    @room_1.play_song(@song_1)
    @room_1.queue_song(@song_2)
    @room_1.queue_song(@song_3)
    @room_1.skip_song
    assert_equal(@song_2, @room_1.current_song)
  end

  def test_skip_song__one_skip
    @room_1.play_song(@song_1)
    @room_1.queue_song(@song_2)
    @room_1.queue_song(@song_3)
    @room_1.skip_song(1)
    assert_equal(@song_2, @room_1.current_song)
  end

  def test_skip_song__two_skips
    @room_1.play_song(@song_1)
    @room_1.queue_song(@song_2)
    @room_1.queue_song(@song_3)
    @room_1.skip_song(2)
    assert_equal(@song_3, @room_1.current_song)
  end

  def test_check_in__one_guest
    @room_1.check_in(@guest_1)
    assert_equal(1, @room_1.guests.length)
    assert_equal(true, @room_1.guests.include?(@guest_1))
    assert_equal([{guest: @guest_1, purchase: "entry fee", cost: 10}], @room_1.history)
  end

  def test_check_in__too_many_guests
    @room_2.check_in(@guest_1)
    @room_2.check_in(@guest_2)
    @room_2.check_in(@guest_3)
    assert_equal(2, @room_2.guests.length)
    assert_equal(false, @room_2.guests.include?(@guest_3))
  end

  def check_in__existing_guest
    @room_1.check_in(@guest_1)
    @room_1.check_in(@guest_1)
    assert_equal(1, @room_2.guests.length)
  end

  def test_check_out__exisiting_guest
    @room_1.check_in(@guest_1)
    @room_1.check_out(@guest_1)
    assert_equal(false, @room_1.guests.include?(@guest_1))
    assert_equal(0, @room_1.guests.length)
  end

  def test_check_out__non_exisiting_guest
    @room_1.check_in(@guest_1)
    @room_1.check_out(@guest_2)
    assert_equal(1, @room_1.guests.length)
    assert_equal(false, @room_1.guests.include?(@guest_2))
  end

  def test_record_order
    @guest_1.buy_drink(@drink_1, @bar, @room_1)
    assert_equal(@room_1.history, [{guest: @guest_1, purchase: @drink_1, cost: 5}])
    assert_equal(5, @room_1.gross)
  end



end
