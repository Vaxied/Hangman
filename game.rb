module Hangman
  # Class that manages most of the game
  class Game

    attr_accessor :word, :board, :player, :failed_letters, :guessed_letters, :tries, :letter, :saver, :loader

    def initialize(player = '', board = Board.new(self), loader = Loader.new(self), saver = Saver.new)
      @board = board
      @player = player
      @loader = loader
      @saver = saver
      @word = ''
      @failed_letters = []
      @guessed_letters = []
      @letter = ''
    end



    def load_word
      filename = 'dictionary.txt'
      File.open(filename, 'r')
      word_amount = count_words_in_file(filename)
      # row_number = generate_number(word_amount)
      # puts row_number
      loop do
        row_number = generate_number(word_amount)
        chosen_word = choose_word(row_number, filename)
        p chosen_word
        break if p chosen_word.length > 4 && chosen_word.length < 13
      end
      puts word
      puts 'hiding word'
      board.build_row(word)
    end

    def generate_number(word_amount)
      rand(word_amount)
    end

    def choose_word(number, filename)
      line = 0
      File.foreach(filename) do |word|
        # puts word
        # puts line
        line += 1
        next if number != line

        self.word = word.chomp
      end
      self.word
    end

    def count_words_in_file(filename)
      word_amount = 0
      File.open(filename, 'r')
      File.foreach(filename) { word_amount += 1 }
      word_amount - 1
    end

    def play
      load_word if word.empty?
      loop do
        loop do
          self.letter = ask_for_letter
          break unless guessed_letters.include?(letter)
        end
        compare_letter_to_word(letter, word)
        p guessed_letters
        board.build_row(word)
        # break if player.tries.zero?
        break if game_over?
      end
    end

    def ask_for_letter
      puts 'Please guess a letter'
      loop do
        self.letter = gets.chomp.downcase
        puts 'Please try another letter, this one was already guessed' if guessed_letters.include?(letter)
        puts 'Please only enter one letter' unless letter.length == 1
        puts 'Please enter a letter' unless letter.match?(/[[:alpha:]]/)
        return letter if letter.length == 1 && letter.match?(/[[:alpha:]]/)
      end
    end

    def compare_letter_to_word(letter, word)
      guessed_letters.push(letter)
      if word.include?(letter)
        insert_letter(letter, word)
        puts "great! the #{letter} is present"
      elsif word.include?(letter.upcase)
        insert_letter(letter.upcase, word)
        puts "great! The #{letter} is present"
      else
        failed_letters.push(letter)
        player.tries -= 1
        puts "The letter #{letter} isn't present in the word, you have #{player.tries} tries left"
      end
    end

    def insert_letter(letter, word)
      # count_letters_in_word(letter, word)
      # words.count(letter)
      board.substitute_letters(letter, word)
    end

    def game_over?
      if player.tries.zero?
        puts "You have no more tries left, the word was #{word}"
        saver.save_game(self)
        return true
      elsif board.row.each.include?('_')
        # game still going
        return false
      end
      unless board.row.each.include?('_')
        puts 'You discovered the word! You won!'
        saver.save_game(self)
        return true
      end
      return false
    end
  end
end
