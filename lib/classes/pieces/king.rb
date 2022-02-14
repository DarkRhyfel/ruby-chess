# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/king_move'
require_relative '../../modules/moves/horizontal_move'
require_relative '../../modules/moves/vertical_move'
require_relative '../../modules/moves/diagonal_move'

# King class
# Represents a king piece and its movements
class King < Piece
  include KingMove
  include HorizontalMove
  include VerticalMove
  include DiagonalMove

  def move(final_position)
    return false unless valid_king_move(final_position)

    valid_horizontal_move(final_position) ||
      valid_vertical_move(final_position) ||
      valid_diagonal_move(final_position)
  end
end
