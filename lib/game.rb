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
    @incorrect_guesses = 0
    @secret_word = choose_secret_word
    @player = Player.new(self)
  end

  def play
    raise NotImplementedError, "#{self.class} must implement the 'play' method."
  end

  private

  def choose_secret_word
    raise NotImplementedError, "#{self.class} must implement the 'choose_secret_word' method."
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
