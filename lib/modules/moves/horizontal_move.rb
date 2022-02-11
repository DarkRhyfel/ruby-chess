# frozen_string_literal: true

# Horizontal move module
# Module to validate horizontal moves
module HorizontalMove
  def valid_horizontal_move(final_position)
    initial_row, = position
    final_row, final_column = final_position

    if initial_row != final_row || !final_column.between?(1, 8)
      false
    else
      true
    end
  end
end
