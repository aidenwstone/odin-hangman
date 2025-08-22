# frozen_string_literal: true

# The Player class manages a player.
# It provides functionality to prompt the user for their name and guesses.
class Player
  def initialize(game)
    @game = game
    @name = prompt_for_name
  end

  def to_s
    @name
  end

  def prompt_for_guess
    print "\n#{@name}, guess an available letter, or the word if you think you know it: "
    loop do
      guess = gets.chomp.downcase
      return guess if (guess.length == 1 || guess.length.between?(5, 12)) && @game.available?(guess)

      print "\nInvalid guess, please try again: "
    end
  end

  private

  def prompt_for_name
    print 'Please enter your name: '
    gets.chomp
  end
end
