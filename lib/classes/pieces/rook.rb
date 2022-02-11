# frozen_string_literal: true

# External references
require_relative '../base/piece'
require_relative '../../modules/horizontal_move'
require_relative '../../modules/vertical_move'

# Rook class
# Represents the rook and it's possible movements
class Rook < Piece
  include HorizontalMove
  include VerticalMove
end
