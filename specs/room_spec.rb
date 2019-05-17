require("minitest/autorun")
require("minitest/rg")
require_relative("../room")
require_relative("../guest")
require_relative("../song")

class RoomTest < MiniTest::Test

  def setup
    @room_1 = Room.new("80s Party Room", 8, 10)
    @song_1 = Song.new("Life on Mars")
    @song_2 = Song.new("Rocketman")
    @song_3 = Song.new("In The Air Tonight")
    @guest_1 = Guest.new("David", 30, @song_1, 100)
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


end
