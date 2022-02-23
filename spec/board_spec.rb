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
      it 'returns an error message' do
        error_message = "The position you selected doesn't have a piece in it! Select another one."
        move_result = board_test.move_piece('W', ['A', 3], ['A', 4])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when requesting a move of an enemy piece' do
      it 'returns an error message' do
        error_message = 'The piece you selected is not yours! Choose another one.'
        move_result = board_test.move_piece('W', ['A', 7], ['A', 5])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when requesting a move of a friendly piece to an invalid position' do
      it 'returns an error message' do
        error_message = "The piece you selected can't move to that position! Select another."
        move_result = board_test.move_piece('W', ['A', 2], ['A', 7])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when the piece move has to resolve a check and it does not' do
      before do
        board_test.instance_variable_set(:@in_check, true)
        board_test.instance_variable_set(
          :@board_state,
          [Pawn.new('W', ['A', 2]), King.new('W', ['E', 1]), Rook.new('B', ['E', 4])]
        )
      end

      it 'returns an error message' do
        error_message = 'You have to protect your king! Make another move.'
        move_result = board_test.move_piece('W', ['A', 2], ['A', 3])
        expect(move_result).to eq MoveResult.new(false, error_message)
      end
    end

    context 'when everything is valid' do
      it 'updates the piece position' do
        expect(board_test).to receive(:update_state)
        board_test.move_piece('W', ['A', 2], ['A', 3])
      end

      it 'returns a positive result' do
        result_message = ''
        move_result = board_test.move_piece('W', ['A', 2], ['A', 3])
        expect(move_result).to eq MoveResult.new(true, result_message)
      end
    end
  end

  describe '#verify_check_status' do # rubocop:disable Metrics/BlockLength
    context 'when there are no attacking pieces' do
      it 'returns no_check' do
        check_result = board_test.verify_check_status('W')
        expect(check_result).to eq :no_check
      end
    end

    context 'when there are attacking pieces but there is a way out' do # rubocop:disable Metrics/BlockLength
      context 'by capturing the attacking piece' do
        before do
          board_test.instance_variable_set(
            :@board_state,
            [King.new('W', ['A', 1]), Rook.new('B', ['A', 3]), Queen.new('W', ['C', 1])]
          )
        end

        it 'returns only a check' do
          check_result = board_test.verify_check_status('W')
          expect(check_result).to eq :check
        end
      end

      context 'by blocking the attacking piece' do
        before do
          board_test.instance_variable_set(
            :@board_state,
            [King.new('W', ['A', 1]), Bishop.new('B', ['D', 4]), Rook.new('W', ['F', 3])]
          )
        end

        it 'returns only a check' do
          check_result = board_test.verify_check_status('W')
          expect(check_result).to eq :check
        end
      end

      context 'by moving the king' do
        before do
          board_test.instance_variable_set(
            :@board_state,
            [King.new('W', ['A', 1]), Rook.new('B', ['A', 5]), Knight.new('W', ['G', 3])]
          )
        end

        it 'returns only a check' do
          check_result = board_test.verify_check_status('W')
          expect(check_result).to eq :check
        end
      end
    end

    context 'when there are attacking pieces and there is no way out' do
      before do
        board_test.instance_variable_set(
          :@board_state,
          [King.new('W', ['A', 1]), Rook.new('B', ['A', 5]), Queen.new('B', ['C', 1]), Knight.new('W', ['G', 3])]
        )
      end

      it 'returns a checkmate' do
        check_result = board_test.verify_check_status('W')
        expect(check_result).to eq :checkmate
      end
    end
  end
end
