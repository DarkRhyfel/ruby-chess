# frozen_string_literal: true

# External references
require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'
require_relative '../extras/move_result'
require_relative '../../modules/utils/board_initializer'
require_relative '../../modules/utils/board_status'
require_relative '../../resources/messages/board_messages'

# Board class
# Represents the game board and its state
class Board
  include BoardInitializer
  include BoardStatus

  attr_reader :board_state, :in_check

  def initialize
    @board_state = initialize_pieces
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
end
