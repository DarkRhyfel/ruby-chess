# frozen_string_literal: true

# External references
require_relative '../base/piece'
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
end
