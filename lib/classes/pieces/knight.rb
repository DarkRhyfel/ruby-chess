# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/knight_move'

# Knight class
# Represents a knight and its movements
class Knight < Piece
  include KnightMove
end
