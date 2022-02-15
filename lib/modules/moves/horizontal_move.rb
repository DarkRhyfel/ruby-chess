# frozen_string_literal: true

# Horizontal move module
# Module to validate horizontal moves
module HorizontalMove
  def generate_horizontal_moves(board_state, limit = 7)
    generate_horizontal(position, board_state, limit, 1)
      .concat(generate_horizontal(position, board_state, limit, -1))
  end

  private

  def generate_horizontal(initial, board_state, limit, operator) # rubocop:disable Metrics/MethodLength
    movements = []
    current_column, current_row = initial

    limit.times do
      current_column = (current_column.ord + operator).chr

      break unless inside_board?([current_column, current_row])

      obstacle_piece = board_state.find { |piece| piece.position == [current_column, current_row] }

      if obstacle_piece.nil?
        movements << [[current_column, current_row], false]
      else
        movements << [[current_column, current_row], true] unless obstacle_piece.color == color
        break
      end
    end

    movements
  end
end
