# frozen_string_literal: true

# Horizontal move module
# Module to validate horizontal moves
module HorizontalMove
  def generate_horizontal_moves(board_state, limit = 7)
    generate_horizontal(position, board_state, limit, 1, 'H1')
      .concat(generate_horizontal(position, board_state, limit, -1, 'H2'))
  end

  private

  def generate_horizontal(initial, board_state, limit, operator, id) # rubocop:disable Metrics/MethodLength
    moves = []
    current_column, current_row = initial

    limit.times do
      current_column = (current_column.ord + operator).chr

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
end
