class Guest

  attr_reader :name, :age, :favourite_song, :wallet

  def initialize(name, age, favourite_song, wallet)
    @name = name
    @age = age
    @favourite_song = favourite_song
    @wallet = wallet
  end

end
