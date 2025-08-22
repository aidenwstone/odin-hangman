# frozen_string_literal: true

require 'Colorize'
require_relative 'player'

# The Game class manages a game of Hangman.
# It provides functionality to run the game loop, evaluate guesses, display feedback, etc.
class Game
  MAX_INCORRECT_GUESSES = 8
  ALPHABET_LETTERS = ('a'..'z').to_a

  def initialize
    @available_letters = ALPHABET_LETTERS
    @incorrect_guesses = []
    @secret_word = choose_secret_word
    @revealed_word = Array.new(@secret_word.size, '_').join
    @player = Player.new(self)
  end

  def play
    raise NotImplementedError, "#{self.class} must implement the 'play' method."
  end

  def available?(guess)
    @incorrect_guesses.none?(guess)
  end

  private

  def choose_secret_word
    File.open('data/words.txt').readlines(chomp: true)
        .filter { |current_word| current_word.length.between?(5, 12) }
        .sample
  end

  def win?
    @revealed_word == @secret_word
  end

  def lose?
    @incorrect_guesses.length == MAX_INCORRECT_GUESSES
  end

  def clear_screen
    if Gem.win_platform?
      system 'cls'
    else
      system 'clear'
    end
  end

  def display_status
    # Display the letters of the alphabet, colored to indicate whether they have already been guessed
    colored_letters = ALPHABET_LETTERS.map { |letter| letter.colorize(display_color(letter)) }
    colored_letters.each_slice(6) do |slice|
      puts slice.join(' ')
    end
    # Display the current revealed word
    puts "\n#{@revealed_word.chars.join(' ')}"
    # Display remaining incorrect guesses
    puts "\nYou have #{MAX_INCORRECT_GUESSES - @incorrect_guesses.length} incorrect guesses remaining."
  end

  def display_color(letter)
    if @revealed_word.include?(letter)
      :green
    elsif @incorrect_guesses.include?(letter)
      :red
    else
      :white
    end
  end

  def evaluate_guess(guess)
    if guess == @secret_word
      @revealed_word = guess
    elsif @secret_word.chars.include?(guess)
      @secret_word.each_char.with_index do |char, index|
        @revealed_word[index] = guess if char == guess
      end
    else
      @incorrect_guesses.push(guess)
    end
  end

  def announce_result
    clear_screen
    display_status
    incorrect_guess_count = @incorrect_guesses.length
    if win?
      puts "\nCongratulations, you won the game with #{incorrect_guess_count} incorrect guesses!"
    else
      puts "\nOops, you made #{incorrect_guess_count} incorrect guesses, thereby losing the game."
    end
    puts "The secret word was \"#{@secret_word}.\""
  end
end
