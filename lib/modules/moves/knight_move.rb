# frozen_string_literal: true

# Knight moves modules
# Validates if a knight is moving correctly
module KnightMove
  def valid_knight_move(final_position)
    return false unless in_board?(final_position)

    column_difference, row_difference = move_difference(position, final_position)

    if (column_difference == 2 && row_difference == 1) || (column_difference == 1 && row_difference == 2)
      true
    else
      false
    end
  end

  private

  def move_difference(initial, final)
    initial_column, initial_row = initial
    final_column, final_row = final

    [(initial_column.ord - final_column.ord).abs, (initial_row - final_row).abs]
  end

  def in_board?(final)
    final_column, final_row = final

    if final_column.ord.between?('A'.ord, 'H'.ord) && final_row.between?(1, 8)
      true
    else
      false
    end
  end
end
