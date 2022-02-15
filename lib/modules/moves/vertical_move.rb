# frozen_string_literal: true

# Vertical move module
# Validates vertical moves
module VerticalMove
  def generate_vertical_moves(board_state, limit = 7)
    generate_vertical(position, board_state, limit, 1)
      .concat(generate_vertical(position, board_state, limit, -1))
  end

  private

  def generate_vertical(initial, board_state, limit, operator) # rubocop:disable Metrics/MethodLength
    moves = []
    current_column, current_row = initial

    limit.times do
      current_row += operator

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
