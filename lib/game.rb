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

  def display_status
    raise NotImplementedError, "#{self.class} must implement the 'display_feedback' method."
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
    raise NotImplementedError, "#{self.class} must implement the 'announce_result' method."
  end
end
