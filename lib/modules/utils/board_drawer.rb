# frozen_string_literal: true

# Board Drawer module
# Provides method to present the board in console
module BoardDrawer
  def draw_board(board_state)
    board_drawing = []

    board_drawing.concat(draw_top_row)

    ROWS.times do |row|
      board_drawing.concat(draw_row_content(board_state, row))
      board_drawing.concat(draw_bottom_row(row))
    end

    board_drawing.concat(draw_bottom_column_names)

    board_drawing.each { |character| print character }
  end

  private

  def draw_top_row
    draw = []

    COLUMNS.times do |column|
      start = column.zero? ? "   #{BOARD_ELEMENTS[:top_left]}" : BOARD_ELEMENTS[:top_center]
      draw << "#{start}#{BOARD_ELEMENTS[:top_bottom] * 3}"
      draw << BOARD_ELEMENTS[:top_right] if column == COLUMNS - 1
    end

    draw << "\n"

    draw
  end

  def draw_row_content(board_state, row)
    draw = []

    draw << (8 - row).to_s.center(3)

    COLUMNS.times do |column|
      draw << "#{BOARD_ELEMENTS[:side]} #{piece_to_icon(board_state, column, row)} "
    end

    draw << "#{BOARD_ELEMENTS[:side]}\n"
  end

  def draw_bottom_row(row)
    draw = []

    COLUMNS.times do |column|
      draw << define_column_start(column, row)
      draw << (BOARD_ELEMENTS[:top_bottom] * 3)

      end_character = row == ROWS - 1 ? BOARD_ELEMENTS[:bottom_right] : BOARD_ELEMENTS[:right_center]
      draw << end_character if column == COLUMNS - 1
    end

    draw << "\n"

    draw
  end

  def draw_bottom_column_names
    draw = []

    draw << ' ' * 4

    COLUMNS.times do |column|
      draw << ('A'.ord + column).chr.center(4)
    end

    draw << "\n"

    draw
  end

  def piece_to_icon(board_state, column, row)
    position = [('A'.ord + column).chr, 8 - row]

    piece = board_state.find { |board_piece| board_piece.position == position }

    piece.nil? ? ' ' : PIECES[piece_type_mapping(piece)]
  end

  def piece_type_mapping(piece)
    piece_type = piece.class.name.downcase
    piece.color == 'W' ? "white_#{piece_type}".to_sym : "black_#{piece_type}".to_sym
  end

  def define_column_start(column, row)
    if column.zero?
      row == ROWS - 1 ? "   #{BOARD_ELEMENTS[:bottom_left]}" : "   #{BOARD_ELEMENTS[:left_center]}"
    else
      row == ROWS - 1 ? BOARD_ELEMENTS[:bottom_center] : BOARD_ELEMENTS[:center]
    end
  end
end
