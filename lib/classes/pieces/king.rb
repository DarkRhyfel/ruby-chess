# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/king_move'
require_relative '../../modules/moves/horizontal_move'
require_relative '../../modules/moves/vertical_move'
require_relative '../../modules/moves/diagonal_move'
require_relative '../../modules/utils/board_utils'

# King class
# Represents a king piece and its movements
class King < Piece
  include KingMove
  include HorizontalMove
  include VerticalMove
  include DiagonalMove
  include BoardUtils

  def valid_moves(board_state)
    generate_king_moves(board_state)
  end
end
