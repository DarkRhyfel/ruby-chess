# frozen_string_literal: true

# Diagonal Move module
# Validates correct diagonal moves
module DiagonalMove
  def generate_diagonal_moves(board_state, limit = 7)
    generate_diagonal(position, board_state, limit, [1, 1], 'D1')
      .concat(generate_diagonal(position, board_state, limit, [-1, -1], 'D2'))
      .concat(generate_diagonal(position, board_state, limit, [1, -1], 'D3'))
      .concat(generate_diagonal(position, board_state, limit, [-1, 1], 'D4'))
  end

  def generate_diagonal(initial, board_state, limit, operators, id) # rubocop:disable Metrics/MethodLength
    moves = []
    current_column, current_row = initial
    column_operator, row_operator = operators

    limit.times do
      current_column, current_row = update_position(current_column, column_operator, current_row, row_operator)

      break unless inside_board?([current_column, current_row])

      obstacle_piece = board_state.find { |piece| piece.position == [current_column, current_row] }

      if obstacle_piece.nil?
        moves << PossibleMove.new([current_column, current_row], false, id)
      else
        moves << PossibleMove.new([current_column, current_row], true, id) unless obstacle_piece.color == color
        break
      end
    end

    moves
  end

  private

  def update_position(column, column_operator, row, row_operator)
    [(column.ord + column_operator).chr, row + row_operator]
  end
end
