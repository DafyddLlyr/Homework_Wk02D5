class Room

  attr_reader :name, :capacity, :entry_fee, :playlist, :current_song_index, :guests, :gross
  attr_accessor :history

  def initialize(name, capacity, entry_fee)
    @name = name
    @capacity = capacity
    @entry_fee = entry_fee
    @playlist = []
    @current_song_index = 0
    @guests = []
    @gross = 0
    @history = []
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

  def check_in(guest)
    return if @guests.length == capacity
    return if @guests.include?(guest)
    @guests.push(guest)
    @history.push({name: guest.name, purchase: "entry fee", cost: @entry_fee})
    guest.join_room(self)
  end

  def check_out(guest)
    return if @guests.include?(guest) == false
    @guests.delete(guest)
  end

  def record_order(drink, guest)
    @history.push({name: guest.name, purchase: drink, cost: drink.price})
  end



end
