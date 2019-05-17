class Room

  attr_reader :name, :capacity, :entry_fee, :playlist, :current_song_index

  def initialize(name, capacity, entry_fee)
    @name = name
    @capacity = capacity
    @entry_fee = entry_fee
    @playlist = []
    @current_song_index = 0
  end

  def current_song()
    return @playlist[@current_song_index]
  end

  def play_song(song)
    @playlist.push(song)
    @current_song_index = @playlist.length - 1
  end

  def queue_song(song)
    @playlist.push(song)
  end

  def skip_song(skip_count = 1)
    @current_song_index += skip_count
  end

end
