require("minitest/autorun")
require("minitest/rg")
require_relative("../karaoke")
require_relative("../room")
require_relative("../bar")
require_relative("../drink")
require_relative("../guest")
require_relative("../song")

class KaraokeTest < MiniTest::Test

  def setup
    
    # Create environment
    @room_1 = Room.new("90s Heaven", 8, 10)
    @room_2 = Room.new("80s Glam Rock Room", 12, 20)
    @room_3 = Room.new("60s Pop Palace", 10, 15)
    @rooms = [@room_1, @room_2, @room_3]

    @drink_1 = Drink.new("Beer", 5)
    @drink_2 = Drink.new("Whisky", 10)

    @bar_1 = Bar.new("Downstairs Bar", 100, {@drink_1=>1000, @drink_2=>1000})
    @bar_2 = Bar.new("Upstairs Bar", 200, {@drink_1=>1000, @drink_2=> 200})
    @bars = [@bar_1, @bar_2]

    @song_1 = Song.new("Mmmm Bop")
    @song_2 = Song.new("C'est la Vie")
    @song_3 = Song.new("Sweet Child O' Mine")
    @song_4 = Song.new("You Give Love A Bad Name")
    @song_5 = Song.new("Son of a Preacher Man")
    @song_6 = Song.new("Good Vibrations")

    @guest_1 = Guest.new("Bob", 20, @song_1, 1000)
    @guest_2 = Guest.new("Dave", 21, @song_2, 1000)
    @guest_3 = Guest.new("Kim", 22, @song_3, 1000)
    @guest_4 = Guest.new("Gina", 23, @song_4, 1000)
    @guest_5 = Guest.new("Gill", 24, @song_5, 1000)
    @guest_6 = Guest.new("Tim", 24, @song_6, 1000)

    @karaoke = Karaoke.new("Dafydd's Karaoke Bar", @rooms, @bars)


    # Simulate actions at karaoke bar
    @guest_1.join_room(@room_1)
    @guest_2.join_room(@room_1)
    5.times { @guest_1.buy_drink(@drink_2, @bar_1, @room_1) }
    100.times{ @guest_2.queue_song(@song_2, @room_1) } # Most played

    @guest_3.join_room(@room_2)
    @guest_4.join_room(@room_2)
    5.times { @guest_3.play_song(@song_3, @room_2) }
    100.times { @guest_2.buy_drink(@drink_1, @bar_2, @room_2)} # Most profit

    @guest_5.join_room(@room_3)
    @guest_6.join_room(@room_3)
    5.times { @guest_5.buy_drink(@drink_2, @bar_1, @room_3) }
    5.times { @guest_6.buy_drink(@drink_1, @bar_2, @room_3) }
    10.times { @guest_5.queue_song(@song_5, @room_3) }
    10.times { @guest_6.play_song(@song_6, @room_3) }

  end

  def test_name
    assert_equal("Dafydd's Karaoke Bar", @karaoke.name)
  end

  def test_rooms
    assert_equal(@rooms, @karaoke.rooms)
  end

  def test_bars
    assert_equal(@bars, @karaoke.bars)
  end

  def test_total_guests
    assert_equal(6, @karaoke.total_guests)
  end

  def test_gross
    assert_equal(715, @karaoke.gross)
  end

  def test_all_songs
    result = {@song_2=>100, @song_3=>5, @song_5=>10, @song_6=>10}
    assert_equal(result, @karaoke.all_songs)
  end

  def test_most_played
    assert_equal(@song_2, @karaoke.most_played)
  end

  def test_best_room
    assert_equal(@room_2, @karaoke.best_room)
  end

  def test_all_drinks
    result = { @drink_1=>105, @drink_2=>10 }
    assert_equal(result, @karaoke.all_drinks)
  end

  def test_best_selling_drink
    assert_equal(@drink_1, @karaoke.best_selling_drink)
  end

  def test_biggest_spender
    assert_equal({guest: @guest_2, spent: 510}, @karaoke.biggest_spender)
  end

  def test_avg_spent
    assert_equal(119, @karaoke.avg_spent)
  end

end
