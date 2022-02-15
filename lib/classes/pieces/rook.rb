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

  def valid_moves(board_state)
    generate_horizontal_moves(board_state).concat(generate_vertical_moves(board_state))
  end
end
