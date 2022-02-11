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

  def move(final_position)
    valid_horizontal_move(final_position) || valid_vertical_move(final_position)
  end
end
