# frozen_string_literal: true

ROWS = 8
COLUMNS = 8

PIECES = {
  white_king: '♔',
  white_queen: '♕',
  white_rook: '♖',
  white_bishop: '♗',
  white_knight: '♘',
  white_pawn: '♙',
  black_king: '♚',
  black_queen: '♛',
  black_rook: '♜',
  black_bishop: '♝',
  black_knight: '♞',
  black_pawn: '♟︎'
}.freeze

BOARD_ELEMENTS = {
  side: '│',
  top_bottom: '─',
  top_left: '┌',
  top_right: '┐',
  bottom_left: '└',
  bottom_right: '┘',
  left_center: '├',
  right_center: '┤',
  top_center: '┬',
  bottom_center: '┴',
  center: '┼'
}.freeze
