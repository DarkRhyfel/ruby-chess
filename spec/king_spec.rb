# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/king'

# Tests for king piece
RSpec.describe King do # rubocop:disable Metrics/BlockLength
  subject(:king_test) { King.new('B', ['E', 2]) }

  describe '#valid_moves' do
    context 'when calling method for king valid moves' do
      before do
        allow(king_test).to receive(:generate_horizontal_moves).and_return([[['D', 2], false], [['F', 2], false]])
        allow(king_test).to receive(:generate_vertical_moves).and_return([[['E', 1], false], [['E', 3], false]])
        allow(king_test).to receive(:generate_diagonal_moves).and_return([[['D', 3], false], [['F', 1], false]])
      end

      it 'receives a call for horizontal moves with a limit' do
        expect(king_test).to receive(:generate_horizontal_moves).with([], 1)
        king_test.valid_moves([])
      end

      it 'receives a call for vertical moves with a limit' do
        expect(king_test).to receive(:generate_vertical_moves).with([], 1)
        king_test.valid_moves([])
      end

      it 'receives a call for diagonal moves with a limit' do
        expect(king_test).to receive(:generate_diagonal_moves).with([], 1)
        king_test.valid_moves([])
      end
    end

    context 'when requesting valid moves for the king' do
      it 'generates 8 possible moves' do
        king_moves = king_test.valid_moves([])
        expect(king_moves.count).to eq 8
      end
    end
  end
end
