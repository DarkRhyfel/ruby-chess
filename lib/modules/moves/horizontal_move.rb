# frozen_string_literal: true

# Horizontal move module
# Module to validate horizontal moves
module HorizontalMove
  def valid_horizontal_move(final_position)
    initial_column, = position
    final_column, final_row = final_position

    if initial_column != final_column || !final_row.between?(1, 8)
      false
    else
      true
    end
  end
end
