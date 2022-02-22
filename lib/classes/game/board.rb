# frozen_string_literal: true

# External references
require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'
require_relative '../../resources/messages/board_messages'
require_relative '../extras/move_result'

# Board class
# Represents the game board and its state
class Board
  attr_reader :board_state, :in_check

  def initialize
    @board_state = initialize_pieces
    @in_check = false
  end

  def move_piece(current_player, initial, final)
    selected_piece = board_state.find { |piece| piece.position == initial }

    legal, result = check_illegal_move(current_player, selected_piece)

    return result unless legal

    valid_move = selected_piece.valid_moves(board_state).find { |move| move.position == final }

    correct_move, result = check_updated_state(board_state, current_player, initial, valid_move)

    return result unless correct_move

    @board_state = update_state(board_state, initial, valid_move)

    MoveResult.new(true, '')
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

  def check_illegal_move(player, selected_piece)
    if selected_piece.nil?
      [false, MoveResult.new(false, BOARD_MESSAGES[:empty_square])]
    elsif selected_piece.color != player
      [false, MoveResult.new(false, BOARD_MESSAGES[:enemy_piece])]
    else
      [true, nil]
    end
  end

  def check_updated_state(board_state, player, initial, valid_move)
    if valid_move.nil?
      [false, MoveResult.new(false, BOARD_MESSAGES[:invalid_move])]
    elsif in_check && !check_resolved?(board_state.clone, player, initial, valid_move)
      [false, MoveResult.new(false, BOARD_MESSAGES[:unresolved_check])]
    else
      [true, nil]
    end
  end

  def check_resolved?(temp_board, player, initial, valid_move)
    temp_updated_board = update_state(temp_board, initial, valid_move)

    king = temp_updated_board.find { |piece| piece.is_a?(King) && piece.color == player }
    enemy_pieces = temp_updated_board.reject { |piece| piece.color == player }

    enemy_pieces.each do |enemy|
      return false if enemy.valid_moves(temp_updated_board).any? { |move| move.position == king.position }
    end

    true
  end

  def update_state(board_state, initial, valid_move)
    board_state.map do |piece|
      piece.position = valid_move.position if piece.position == initial
      piece
    end

    board_state.delete_if { |piece| piece.position == valid_move.position } if valid_move.state

    board_state
  end
end
