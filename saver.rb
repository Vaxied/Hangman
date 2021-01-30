module Hangman
  class Saver
    def initialize
      # @game = game
      @file = ''
    end

    def save_game(game)
      filename = "#{game.player.name}savefile.txt"
      puts filename
      serialized_object = Marshal::dump(game)
      File.open(filename,'w') do |file|
        file.puts serialized_object
      end
    end
  end
end