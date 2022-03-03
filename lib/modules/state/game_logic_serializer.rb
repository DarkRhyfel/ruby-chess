# frozen_string_literal: true

# External modules
require 'json'

# Game Logic serializer
# Provides methods to serialize a game logic object
module GameLogicSerializer
  def serialize
    hash = {
      '@game_board' => @game_board.serialize,
      '@current_player' => @current_player,
      '@enemy_player' => @enemy_player,
      '@turns_played' => @turns_played,
      '@player_win' => @player_win
    }

    JSON.pretty_generate(hash)
  end

  def deserialize(string)
    JSON.parse(string).each do |variable, value|
      if variable == '@game_board'
        new_board = Board.new
        new_board.deserialize(value)
        value = new_board
      end

      instance_variable_set variable, value
    end
  end
end
