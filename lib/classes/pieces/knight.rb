# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/knight_move'
require_relative '../../modules/utils/board_utils'

# Knight class
# Represents a knight and its movements
class Knight < Piece
  include KnightMove
  include BoardUtils

  def move(final_position)
    valid_knight_move(final_position)
  end
end
