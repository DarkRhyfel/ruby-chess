# frozen_string_literal: true

# King move module
# Validates if a king's move is out of boundaries
module KingMove
  def valid_king_move(final_position)
    move_difference = limit_difference(position, final_position)

    move_difference.all? { |difference| difference <= 1 }
  end

  private

  def limit_difference(initial, final)
    initial_column, initial_row = initial
    final_column, final_row = final

    column_difference = (initial_column.ord - final_column.ord).abs
    row_difference = (initial_row - final_row).abs

    [column_difference, row_difference]
  end
end
