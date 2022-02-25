# frozen_string_literal: true

# Board Status module
# Provides method to initiliaze or check the board status
module BoardStatus
  private

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
      @in_check = false
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
      @in_check = true
      true
    else
      false
    end
  end
end
