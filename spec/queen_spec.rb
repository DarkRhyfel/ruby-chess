# frozen_string_literal: true

# External reference
require_relative '../lib/classes/pieces/queen'

# Test for Queen
RSpec.describe Queen do # rubocop:disable Metrics/BlockLength
  subject(:queen_test) { Queen.new('B', ['D', 1]) }

  describe '#valid_moves' do # rubocop:disable Metrics/BlockLength
    context 'when calling the method for queen valid moves' do
      before do
        allow(queen_test).to receive(:generate_horizontal_moves)
          .and_return([PossibleMove.new(['C', 1], false, 'H2'), PossibleMove.new(['E', 1], false, 'H1')])
        allow(queen_test).to receive(:generate_vertical_moves)
          .and_return([PossibleMove.new(['D', 2], false, 'V1'), PossibleMove.new(['D', 3], false, 'V1')])
        allow(queen_test).to receive(:generate_diagonal_moves)
          .and_return([PossibleMove.new(['C', 2], false, 'D4'), PossibleMove.new(['E', 2], false, 'D1')])
      end

      it 'receives a call for horizontal moves' do
        expect(queen_test).to receive(:generate_horizontal_moves).with([])
        queen_test.valid_moves([])
      end

      it 'receives a call for vertical moves' do
        expect(queen_test).to receive(:generate_vertical_moves).with([])
        queen_test.valid_moves([])
      end

      it 'receives a call for diagonal moves' do
        expect(queen_test).to receive(:generate_diagonal_moves).with([])
        queen_test.valid_moves([])
      end
    end

    context 'when requesting valid moves for the queen' do
      it 'generates 21 possible moves' do
        queen_moves = queen_test.valid_moves([])
        expect(queen_moves.count).to eq 21
      end
    end
  end
end
