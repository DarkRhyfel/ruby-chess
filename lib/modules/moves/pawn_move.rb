# frozen_string_literal: true

# Pawn move module
# Validates pawn movements
module PawnMove
  def generate_pawn_moves(board_state)
    case color
    when 'B' then generate_moves(position, board_state, -1, 7)
    when 'W' then generate_moves(position, board_state, 1, 2)
    else
      []
    end
  end

  private

  def generate_moves(initial, board_state, operator, initial_reference)
    _, initial_row = initial
    limit = initial_reference == initial_row ? 2 : 1

    vertical_positions = generate_vertical(initial, board_state, limit, operator)
    diagonal_positions = generate_diagonal(initial, board_state, 1, 1, operator)
                         .concat(generate_diagonal(initial, board_state, 1, -1, operator))

    filter_moves(vertical_positions, false).concat(filter_moves(diagonal_positions, true))
  end

  def filter_moves(positions, criteria)
    positions.select { |position| position[1] == criteria }
  end
end
