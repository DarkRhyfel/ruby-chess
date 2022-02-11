# frozen_string_literal: true

# Diagonal Move module
# Validates correct diagonal moves
module DiagonalMove
  def valid_diagonal_move(final_position)
    if compare_change(position, final_position) && in_board?(final_position)
      true
    else
      false
    end
  end

  private

  def absolute_change(initial, final)
    (initial - final).abs
  end

  def compare_change(initial_position, final_position)
    initial_column, initial_row = initial_position
    final_column, final_row = final_position

    absolute_change(initial_column.ord, final_column.ord) == absolute_change(initial_row, final_row)
  end

  def in_board?(final_position)
    final_column, final_row = final_position

    if final_column.ord.between?('A'.ord, 'H'.ord) && final_row.between?(1, 8)
      true
    else
      false
    end
  end
end
