# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/bishop'

# Tests for Bishop
RSpec.describe Bishop do # rubocop:disable Metrics/BlockLength
  subject(:bishop_test) { Bishop.new('B', ['D', 4]) }

  describe '#generate_diagonal_moves' do # rubocop:disable Metrics/BlockLength
    context 'when its moving without obstacles' do
      it 'generates 13 moves' do
        diagonal_moves = bishop_test.generate_diagonal_moves([])
        expect(diagonal_moves.count).to eq 13
      end
    end

    context 'when its moving with friendly obstacles 2 squares away' do
      let(:board_test) do
        [
          Bishop.new('B', ['A', 1]),
          Bishop.new('B', ['A', 7]),
          Bishop.new('B', ['G', 1]),
          Bishop.new('B', ['G', 7])
        ]
      end

      it 'generates 8 moves' do
        diagonal_moves = bishop_test.generate_diagonal_moves(board_test)
        expect(diagonal_moves.count).to eq 8
      end
    end

    context 'when its moving with enemy obstacles 2 squares away' do
      let(:board_test) do
        [
          Bishop.new('W', ['A', 1]),
          Bishop.new('W', ['A', 7]),
          Bishop.new('W', ['G', 1]),
          Bishop.new('W', ['G', 7])
        ]
      end

      it 'generates 12 moves' do
        diagonal_moves = bishop_test.generate_diagonal_moves(board_test)
        expect(diagonal_moves.count).to eq 12
      end
    end
  end

  describe '#valid_moves' do
    context 'when calling the method to check valid moves' do
      before do
        allow(bishop_test).to receive(:generate_diagonal_moves)
          .and_return([PossibleMove.new(['C', 5], false, 'D1'), PossibleMove.new(['E', 3], false, 'D4')])
      end

      it 'receives a call for diagonal moves' do
        expect(bishop_test).to receive(:generate_diagonal_moves).with([])
        bishop_test.valid_moves([])
      end
    end

    context 'when requesting valid moves for the bishop' do
      it 'generates 13 possible moves' do
        diagonal_moves = bishop_test.valid_moves([])
        expect(diagonal_moves.count).to eq 13
      end
    end
  end
end
