module Hangman
  class Loader
    def initialize(game)
      @game = game
      @file = ''
    end

    def load_game(file, game)
      serialized_object = File.read "#{file}"
      game = Marshal::load(serialized_object)
      puts "You can continue playing"
    end
  end
end
