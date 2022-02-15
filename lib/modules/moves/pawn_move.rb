# frozen_string_literal: true

# Pawn move module
# Validates pawn movements
module PawnMove
  def valid_pawn_move(final_position)
    initial_column, initial_row = position
    final_column, final_row = final_position

    return false unless initial_column == final_column

    row_difference = color == 'W' ? final_row - initial_row : initial_row - final_row

    return false unless row_difference.positive?

    pawn_movement(row_difference, initial_row, color == 'W' ? 2 : 7)
  end

  private

  def pawn_movement(difference, initial, reference)
    case difference
    when 1
      true
    when 2
      reference == initial
    else
      false
    end
  end
end
