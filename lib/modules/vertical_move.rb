# frozen_string_literal: true

# Vertical move module
# Validates vertical moves
module VerticalMove
  def valid_vertical_move(final_position)
    _, initial_column = position
    final_row, final_column = final_position

    if initial_column != final_column || !final_row.ord.between?('A'.ord, 'H'.ord)
      false
    else
      true
    end
  end
end
