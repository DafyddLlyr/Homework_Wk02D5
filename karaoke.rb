class Karaoke

  attr_reader :name, :rooms, :bars

  def initialize(name, rooms, bars)
    @name = name
    @rooms = rooms
    @bars = bars
  end

  def total_guests
    total = 0
    @rooms.each { |room| total += room.guests.length }
    return total
  end

  def gross
    total = 0
    @rooms.each { |room| total += room.gross }
    return total
  end

  def all_songs
    full_list = []
    for room in @rooms
      for song in room.playlist
        full_list.push(song)
      end
    end
    result = Hash.new(0)
    full_list.each { |song| result[song] += 1 }
    return result
  end

  def most_played
    return all_songs.key(all_songs.values.max)
  end

  def best_room
    gross_list = []
    @rooms.each { |room| gross_list.push(room.gross) }
    for room in @rooms
      return room if room.gross == gross_list.max
    end
  end

  def all_drinks
    full_list = []
    for room in @rooms
      for item in room.history
        full_list.push(item[:purchase]) if item[:purchase].class == Drink
      end
    end
    result = Hash.new(0)
    full_list.each { |drink| result[drink] += 1 }
    return result
  end

  def best_selling_drink
    return all_drinks.key(all_drinks.values.max)
  end

  def biggest_spender
    result = []
    all_guests = []
    all_history = []

    @rooms.each { |room| all_guests.push(room.guests) }
    all_guests.flatten!

    @rooms.each { |room| all_history.push(room.history) }
    all_history.flatten!

    for guest in all_guests
      total = 0
      for item in all_history
        total += item[:cost] if item[:guest] == guest
      end
      result.push({guest=>total})
    end

    big_spender = result.max_by { |item| item.values }

    return { guest: big_spender.keys[0], spent: big_spender.values[0] }

  end

  def avg_spent
    return self.gross / self.total_guests
  end

end
