module Hangman
  class Board

    private
    
    attr_accessor :row, :game

    public

    def initialize(game, _input = {})
      @game = game
      @tries = 7
      @row = []
    end

    def build_row(word)
      if game.guessed_letters == []
        number_of_underscores = word.length
        number_of_underscores.times { row.push('_') }
      end
      puts row.join(' ')
      puts game.failed_letters.join(', ') unless game.failed_letters == []
    end

    def substitute_letters(letter, word)
      array = word.split('')
      # p row
      array.each_with_index do |char, index|
        # p char
        # p index
        row[index] = letter if char == letter
      end
    end

  end
end
