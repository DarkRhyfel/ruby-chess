# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/diagonal_move'

# Bishop class
# Represents a bishop and it's possible movements
class Bishop < Piece
  include DiagonalMove

  def move(final_position)
    valid_diagonal_move(final_position)
  end
end
