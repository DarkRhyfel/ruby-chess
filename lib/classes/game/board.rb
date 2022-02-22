# frozen_string_literal: true

# External references
require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'

# Board class
# Represents the game board and its state
class Board
  attr_reader :board_state

  def initialize
    @board_state = initialize_pieces
  end

  private

  def initialize_pieces
    initialize_set('W', 2, 1)
      .concat(initialize_set('B', 7, 8))
  end

  def initialize_set(color, pawn_row, row)
    pieces = []

    ('A'..'H').each { |column| pieces << Pawn.new(color, [column, pawn_row]) }

    pieces.concat(add_auxiliary_pieces(color, row))
    pieces.concat(add_royalty_pieces(color, row))
  end

  def add_royalty_pieces(color, row)
    [
      Queen.new(color, ['D', row]),
      King.new(color, ['E', row])
    ]
  end

  def add_auxiliary_pieces(color, row)
    pieces = []

    (0..2).each do |i|
      new_piece = return_piece_type(i)

      pieces << new_piece.new(color, [('A'.ord + i).chr, row])
      pieces << new_piece.new(color, [('H'.ord - i).chr, row])
    end

    pieces
  end

  def return_piece_type(position)
    case position
    when 0 then Rook
    when 1 then Knight
    when 2 then Bishop
    end
  end
end

