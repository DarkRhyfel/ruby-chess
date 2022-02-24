# frozen_string_literal: true

# External references
require_relative 'board'
require_relative '../../modules/utils/board_drawer'
require_relative '../../resources/messages/game_messages'
require_relative '../../resources/board/board_items'

# Game Logic class
# Implements methods necessary to play a game
class GameLogic
  include BoardDrawer

  def initialize
    @game_board = Board.new
    @current_player = 'W'
    @enemy_player = 'B'
  end

  def turn
    puts GAME_MESSAGES[:request_move]
    move_request = gets.chomp

    if valid_move_format?(move_request)
      initial, final = parse_requested_move(move_request)
      move_result = @game_board.move_piece(@current_player, initial, final)

      check_move_result(move_result)
    else
      puts GAME_MESSAGES[:request_invalid]
      false
    end
  end

  private

  def valid_move_format?(move_request)
    return false unless move_request.length == 6

    valid_column(move_request[1]) &&
      valid_column(move_request[4]) &&
      valid_row(move_request[2]) &&
      valid_row(move_request[5])
  end

  def valid_column(column)
    column.between?('A', 'H')
  end

  def valid_row(row)
    num_row = row.to_i

    return false if num_row.zero?

    num_row.between?(1, 8)
  end

  def parse_requested_move(move_request)
    [[move_request[1], move_request[2].to_i], [move_request[4], move_request[5].to_i]]
  end

  def change_players
    @current_player, @enemy_player = @enemy_player, @current_player
  end

  def check_move_result(move_result)
    if move_result.state
      change_players
      true
    else
      puts move_result.message
      false
    end
  end
end
