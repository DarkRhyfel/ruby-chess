# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/horizontal_move'
require_relative '../../modules/moves/vertical_move'
require_relative '../../modules/moves/diagonal_move'

# Queen class
# Represents the queen piece and it's movements
class Queen < Piece
  include HorizontalMove
  include VerticalMove
  include DiagonalMove

  def move(final_position)
    valid_horizontal_move(final_position) ||
      valid_vertical_move(final_position) ||
      valid_diagonal_move(final_position)
  end
end
