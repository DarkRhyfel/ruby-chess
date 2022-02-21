# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../extras/possible_move'
require_relative '../../modules/moves/knight_move'
require_relative '../../modules/utils/board_utils'

# Knight class
# Represents a knight and its movements
class Knight < Piece
  include KnightMove
  include BoardUtils

  def valid_moves(board_state)
    generate_knight_moves(board_state)
  end
end
