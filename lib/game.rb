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

  def display_feedback
    raise NotImplementedError, "#{self.class} must implement the 'display_feedback' method."
  end

  def evaluate_guess
    raise NotImplementedError, "#{self.class} must implement the 'evaluate_guess' method."
  end

  def announce_result
    raise NotImplementedError, "#{self.class} must implement the 'announce_result' method."
  end
end
