# frozen_string_literal: true

# Diagonal Move module
# Validates correct diagonal moves
module DiagonalMove
  def generate_diagonal_moves(board_state, limit = 7)
    generate_diagonal(position, board_state, limit, 1, 1)
      .concat(generate_diagonal(position, board_state, limit, -1, -1))
      .concat(generate_diagonal(position, board_state, limit, 1, -1))
      .concat(generate_diagonal(position, board_state, limit, -1, 1))
  end

  private

  def generate_diagonal(initial, board_state, limit, column_operator, row_operator) # rubocop:disable Metrics/MethodLength
    moves = []
    current_column, current_row = initial

    limit.times do
      current_column = (current_column.ord + column_operator).chr
      current_row += row_operator

      break unless inside_board?([current_column, current_row])

      obstacle_piece = board_state.find { |piece| piece.position == [current_column, current_row] }

      if obstacle_piece.nil?
        moves << [[current_column, current_row], false]
      else
        moves << [[current_column, current_row], true] unless obstacle_piece.color == color
        break
      end
    end

    moves
  end
end
