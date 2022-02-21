# frozen_string_literal: true

# Knight moves modules
# Validates if a knight is moving correctly
module KnightMove
  def generate_knight_moves(board_state)
    generate_moves(position, board_state, [2, 1])
      .concat(generate_moves(position, board_state, [1, 2]))
  end

  private

  def generate_moves(initial, board_state, operators) # rubocop:disable Metrics/MethodLength
    moves = []

    move_combinations(operators).each do |changes|
      new_position = calculate_next_knight_position(initial, changes)

      next unless inside_board?(new_position)

      obstacle_piece = board_state.find { |piece| piece.position == new_position }

      if obstacle_piece.nil?
        moves << PossibleMove.new(new_position, false)
      else
        moves << PossibleMove.new(new_position, true) unless obstacle_piece.color == color
      end
    end

    moves
  end

  def move_combinations(operators)
    [-operators[0], operators[0]].product([-operators[1], operators[1]])
  end

  def calculate_next_knight_position(initial, operators)
    [(initial[0].ord + operators[0]).chr, initial[1] + operators[1]]
  end
end
