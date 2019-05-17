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
    @room.check_out(self)
  end

  def play_song(song, room)
    @room.play_song(song)
  end

  def queue_song(song, room)
    @room.queue_song(song)
  end

  def skip_song(room, skip_count = 1)
    @room.skip_song(skip_count)
  end

end
