# frozen_string_literal: true

# External references
require_relative 'board'
require_relative '../../modules/utils/board_drawer'
require_relative '../../modules/state/game_logic_serializer'
require_relative '../../modules/state/save_load'
require_relative '../../resources/messages/game_messages'
require_relative '../../resources/board/board_items'

# Game Logic class
# Implements methods necessary to play a game
class GameLogic
  include BoardDrawer
  include GameLogicSerializer
  include SaveLoad

  def initialize
    @game_board = Board.new
    @current_player = 'W'
    @enemy_player = 'B'
    @turns_played = 0
    @player_win = false
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

  def play
    initialize_game

    until @player_win || @turns_played == 50
      correct_turn = false

      correct_turn = turn until correct_turn

      draw_board(@game_board.board_state)

      @player_win = parse_check_result(@game_board.verify_check_status(@current_player))
      @turns_played += 1
      break if ask_save_game
    end
  end

  private

  def initialize_game
    puts GAME_MESSAGES[:welcome]

    ask_load_game

    draw_board(@game_board.board_state)
  end

  def valid_move_format?(move_request)
    return false unless move_request.length == 6

    valid_column(move_request[1]) && valid_column(move_request[4]) &&
      valid_row(move_request[2]) && valid_row(move_request[5])
  end

  def valid_column(column)
    column.between?('A', 'H')
  end

  def valid_row(row)
    num_row = row.to_i

    num_row.zero? ? false : num_row.between?(1, 8)
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

  def parse_check_result(check_result)
    case check_result
    when :no_check then false
    when :check
      puts GAME_MESSAGES[:check_message]
      false
    when :checkmate
      puts GAME_MESSAGES[:checkmate_message]
      true
    end
  end

  def ask_load_game
    puts GAME_MESSAGES[:ask_load]
    option = gets.chomp.to_i

    return unless option == 1

    saved = load_game
    deserialize(saved) unless saved == 'ERROR'
  end

  def ask_save_game
    puts GAME_MESSAGES[:ask_save]
    option = gets.chomp.to_i

    if option == 1
      save_game(serialize)
      ask_exit_game
    else
      false
    end
  end

  def ask_exit_game
    puts GAME_MESSAGES[:ask_exit]
    option = gets.chomp.to_i

    option == 1
  end
end
