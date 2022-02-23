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
class Board # rubocop:disable Metrics/ClassLength
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

    correct_move, result = check_updated_state(current_player, initial, valid_move)

    return result unless correct_move

    @board_state = update_state(board_state, initial, valid_move)

    MoveResult.new(true, '')
  end

  def verify_check_status(enemy_player)
    attacking_pieces = check_resolved(board_state, enemy_player)

    return :no_check if attacking_pieces.empty?

    protector_pieces = board_state.reject { |piece| piece.color != enemy_player || piece.is_a?(King) }
    attacked_king = board_state.find { |piece| piece.color == enemy_player && piece.is_a?(King) }

    can_avoid_checkmate?(attacking_pieces, protector_pieces, attacked_king) ? :check : :checkmate
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

  def check_updated_state(player, initial, valid_move)
    if valid_move.nil?
      [false, MoveResult.new(false, BOARD_MESSAGES[:invalid_move])]
    elsif in_check && !check_resolved(clone_and_update_temp_board(initial, valid_move), player).empty?
      [false, MoveResult.new(false, BOARD_MESSAGES[:unresolved_check])]
    else
      [true, nil]
    end
  end

  def check_resolved(current_board_state, player)
    attacking_pieces = []

    king = current_board_state.find { |piece| piece.is_a?(King) && piece.color == player }
    enemy_pieces = current_board_state.reject { |piece| piece.color == player }

    enemy_pieces.each do |enemy|
      attacking_pieces << enemy if enemy.valid_moves(current_board_state).any? { |move| move.position == king.position }
    end

    attacking_pieces
  end

  def update_state(current_board_state, initial, valid_move)
    current_board_state.map do |piece|
      piece.position = valid_move.position if piece.position == initial
      piece
    end

    current_board_state.delete_if { |piece| piece.position == valid_move.position } if valid_move.state

    current_board_state
  end

  def clone_and_update_temp_board(initial, valid_move)
    update_state(board_state.clone, initial, valid_move)
  end

  def can_take_attacking_piece?(attacking_pieces, protector_pieces)
    return false if attacking_pieces.count > 1

    protector_pieces.any? do |piece|
      can_take = piece.valid_moves(board_state).any? { |move| move.position == attacking_pieces[0].position }
      return true if can_take
    end

    false
  end

  def can_block_attacking_piece?(attacking_pieces, protector_pieces, attacked_king)
    return false unless attacking_pieces.count == 1 && blockable_pieces(attacking_pieces[0], attacked_king)

    attack_path = calculate_attack_path(attacking_pieces[0], attacked_king)

    protector_pieces.any? do |piece|
      can_block = piece.valid_moves(board_state).any? do |move|
        attack_path.any? { |path| path.position == move.position }
      end
      return true if can_block
    end

    false
  end

  def blockable_pieces(piece, king)
    if piece.is_a?(Rook) || piece.is_a?(Bishop) || piece.is_a?(Queen)
      piece_column, piece_row = piece.position
      king_column, king_row = king.position

      gap = [(piece_column.ord - king_column.ord).abs, (piece_row - king_row).abs]
      gap.any? { |difference| difference > 1 } ? true : false
    else
      false
    end
  end

  def calculate_attack_path(attacking_piece, attacked_king)
    piece_moves = attacking_piece.valid_moves(board_state)
    path_id = (piece_moves.find { |move| move.position == attacked_king.position }).id
    piece_moves.select { |move| move.id == path_id }
  end

  def can_avoid_checkmate?(attacking_pieces, protector_pieces, attacked_king)
    if can_take_attacking_piece?(attacking_pieces, protector_pieces) ||
       can_block_attacking_piece?(attacking_pieces, protector_pieces, attacked_king) ||
       !attacked_king.valid_moves(board_state).empty?
      true
    else
      false
    end
  end
end
