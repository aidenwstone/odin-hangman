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
    raise NotImplementedError, "#{self.class} must implement the 'guess_word' method."
  end

  private

  def prompt_for_name
    print 'Please enter your name: '
    gets.chomp
  end
end
