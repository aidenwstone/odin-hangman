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

  def guess_word
    raise NotImplementedError, "#{self.class} must implement the 'guess_word' method."
  end

  private

  def prompt_for_name
    raise NotImplementedError, "#{self.class} must implement the 'prompt_for_name' method."
  end
end
