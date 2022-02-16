# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/diagonal_move'
require_relative '../../modules/utils/board_utils'

# Bishop class
# Represents a bishop and it's possible movements
class Bishop < Piece
  include DiagonalMove
  include BoardUtils

  def valid_moves(board_state)
    generate_diagonal_moves(board_state)
  end
end
