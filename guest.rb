class Guest

  attr_reader :name, :age, :favourite_song, :wallet

  def initialize(name, age, favourite_song, wallet)
    @name = name
    @age = age
    @favourite_song = favourite_song
    @wallet = wallet
  end

  def join_room(room)
    @wallet -= room.entry_fee
  end

  def leave_room(room)
    room.check_out(self)
  end

  def play_song(song, room)
    room.play_song(song)
  end

  def queue_song(song, room)
    room.queue_song(song)
  end

  def skip_song(room, skip_count = 1)
    room.skip_song(skip_count)
  end

  def check_favourite_song(room)
    return "Woohoo!" if room.playlist.include?(@favourite_song)
  end

  def buy_drink(drink, bar, room)
    return if drink.price > @wallet
    @wallet -= drink.price
    bar.sell_drink(drink, room, self)
  end

end
