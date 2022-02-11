# frozen_string_literal: true

# Vertical move module
# Validates vertical moves
module VerticalMove
  def valid_vertical_move(final_position)
    _, initial_row = position
    final_column, final_row = final_position

    if initial_row != final_row || !final_column.ord.between?('A'.ord, 'H'.ord)
      false
    else
      true
    end
  end
end
