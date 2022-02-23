# frozen_string_literal: true

# King Moves module
# Generates the king possible moves taking into account enemy pieces.
module KingMove
  def generate_king_moves(board_state)
    filter_moves_by_enemy(generate_possible_moves(board_state), board_state)
  end

  private

  def generate_possible_moves(board_state)
    generate_horizontal_moves(board_state, 1)
      .concat(generate_vertical_moves(board_state, 1))
      .concat(generate_diagonal_moves(board_state, 1))
  end

  def filter_moves_by_enemy(moves, board_state)
    enemy_pieces = board_state.reject { |piece| piece.color == color || piece.is_a?(King) }

    enemy_pieces.each { |enemy| moves = moves.difference(enemy.valid_moves(board_state)) }

    moves
  end
end
