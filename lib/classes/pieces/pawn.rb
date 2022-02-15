# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/moves/pawn_move'

# Pawn class
# Represents a pawn and its movements
class Pawn < Piece
  include PawnMove
end
