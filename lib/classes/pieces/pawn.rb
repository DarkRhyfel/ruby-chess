# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../extras/possible_move'
require_relative '../../modules/moves/pawn_move'
require_relative '../../modules/moves/vertical_move'
require_relative '../../modules/moves/diagonal_move'
require_relative '../../modules/utils/board_utils'

# Pawn class
# Represents a pawn and its movements
class Pawn < Piece
  include PawnMove
  include VerticalMove
  include DiagonalMove
  include BoardUtils

  def valid_moves(board_state)
    generate_pawn_moves(board_state)
  end
end
