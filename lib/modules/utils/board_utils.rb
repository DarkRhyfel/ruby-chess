# frozen_string_literal: true

# Board utils modules
# Exposes some common methods to use with and for the board
module BoardUtils
  def inside_board?(position)
    column, row = position

    column.ord.between?('A'.ord, 'H'.ord) && row.between?(1, 8)
  end
end
