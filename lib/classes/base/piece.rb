# frozen_string_literal: true

# Piece base class
# Includes the basic characteristics of a chess piece
class Piece
  attr_accessor :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def move
    raise 'NotImplemented'
  end
end
