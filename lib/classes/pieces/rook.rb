# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/horizontal_move'
require_relative '../../modules/moves/vertical_move'
require_relative '../../modules/utils/board_utils'

# Rook class
# Represents the rook and it's possible movements
class Rook < Piece
  include HorizontalMove
  include VerticalMove
  include BoardUtils

  def move(final_position)
    valid_horizontal_move(final_position) || valid_vertical_move(final_position)
  end
end
