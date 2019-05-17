require("minitest/autorun")
require("minitest/rg")
require_relative("../song")

class SongTest < MiniTest::Test

    def setup
      @song = Song.new("Everybody Hurts")
    end

    def test_song_name
      assert_equal("Everybody Hurts", @song.name)
    end

end
