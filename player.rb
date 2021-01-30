module Hangman
  # class for player(s)
  class Player

    attr_accessor :tries, :name

    def initialize(input)
      @name = input[:name]
      @tries = 7
    end

    def self.greet_player
      puts 'Welcome to Hangman'
      puts 'Do you want to start a new game or load a previous one?'
      options = ['1. Start a new game', '2. Load a previous game']
      puts options
      select_option
    end

    def self.create_player
      Hangman::Player.new({ name: gets.chomp })
    end

    def self.select_option
      n = gets.chomp.to_i
      case n
      when 1
        puts 'Please input your name:'
        player = create_player
        Hangman::Game.new(player).play
        # TO DO
      when 2
        # Load a saved game TO DO
        files = Dir.glob '*savefile.txt'
        p files
      else
        # Exit
        exit(0)
      end
    end

  end
end
