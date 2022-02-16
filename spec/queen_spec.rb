# frozen_string_literal: true

# External reference
require_relative '../lib/classes/pieces/queen'

# Test for Queen
RSpec.describe Queen do
  subject(:queen_test) { Queen.new('B', ['D', 1]) }

  describe '#valid_moves' do
    context 'when calling the method for queen valid moves' do
      before do
        allow(queen_test).to receive(:generate_horizontal_moves).and_return([[['C', 1], false], [['E', 1], false]])
        allow(queen_test).to receive(:generate_vertical_moves).and_return([[['D', 2], false], [['D', 3], false]])
        allow(queen_test).to receive(:generate_diagonal_moves).and_return([[['C', 2], false], [['E', 2], false]])
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
  end
end
