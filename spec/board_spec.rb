# frozen_string_literal: true

# External references
require_relative '../lib/classes/game/board'

# Tests for Board, including the game logic
RSpec.describe Board do # rubocop:disable Metrics/BlockLength
  subject(:board_test) { Board.new }

  describe '#initialize' do
    context 'when creating a new board' do
      it 'returns 32 pieces in total' do
        current_board = board_test.board_state
        expect(current_board.count).to eq 32
      end
    end
  end

  describe '#move_piece' do # rubocop:disable Metrics/BlockLength
    context 'when requesting a move in an empty square' do
      xit 'returns an error message' do
        error_message = "The position you selected doesn't have a piece in it! Select another one."
        move_result = board_test.move_piece('P', ['A', 2], ['A', 3])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when requesting a move of an enemy piece' do
      xit 'returns an error message' do
        error_message = 'The piece you selected is not yours! Choose another one.'
        move_result = board_test.move_piece('P', ['A', 7], ['A', 5])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when requesting a move of a friendly piece to an invalid position' do
      context 'and is an invalid position' do
        xit 'returns an error message' do
          error_message = "The piece you selected can't move to that position! Select another."
          move_result = board_test.move_piece('P', ['A', 2], ['A', 7])
          expect(move_result).to eq MoveResult.new(false, error_message)
        end
      end

      context 'and is a valid position' do
        xit 'continues the process' do
          expect(board_test).to receive(:include?).and_return(true)
          board_test.move_piece('P', ['A', 2], ['A', 3])
        end
      end
    end

    context 'when the piece move has to resolve a check' do
      context 'and it does not' do
        xit 'returns an error message' do
          error_message = 'You have to protect your king! Make another move.'
          move_result = board_test.move_piece('P', ['A', 2], ['A', 3])
          expect(move_result).to eq MoveResult.new(false, error_message)
        end
      end

      context 'and it does' do
        xit 'continues the process' do
          expect(board_test).to receive(:verify_check_status)
          board_test.move_piece('P', ['A', 2], ['A', 3])
        end
      end
    end

    context 'when everything is valid' do
      xit 'updates the piece position' do
        expect(board_test).to receive(:update_board_state)
        board_test.move_piece('P', ['A', 2], ['A', 3])
      end

      xit 'returns a positive result' do
        result_message = ''
        move_result = board_test.move_piece('P', ['A', 2], ['A', 3])
        expect(move_result).to eq MoveResult.new(true, result_message)
      end
    end
  end
end
