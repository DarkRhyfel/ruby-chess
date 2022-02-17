# frozen_string_literal: true

# Knight moves modules
# Validates if a knight is moving correctly
module KnightMove
  def generate_knight_moves(board_state)
    generate_moves(position, board_state, 2, 1)
      .concat(generate_moves(position, board_state, 1, 2))
  end

  private

  def generate_moves(initial, board_state, column_operator, row_operator) # rubocop:disable Metrics/MethodLength
    moves = []
    initial_column, initial_row = initial

    move_combinations(column_operator, row_operator).each do |column_change, row_change|
      new_position = calculate_next_knight_position(initial_column, initial_row, column_change, row_change)

      next unless inside_board?(new_position)

      obstacle_piece = board_state.find { |piece| piece.position == new_position }

      if obstacle_piece.nil?
        moves << [new_position, false]
      else
        moves << [new_position, true] unless obstacle_piece.color == color
      end
    end

    moves
  end

  def move_combinations(column_operator, row_operator)
    [-column_operator, column_operator].product([-row_operator, row_operator])
  end

  def calculate_next_knight_position(initial_column, initial_row, column_change, row_change)
    [(initial_column.ord + column_change).chr, initial_row + row_change]
  end
end
