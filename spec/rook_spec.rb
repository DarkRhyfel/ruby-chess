# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/rook'

# Tests for Rook class and it's methods
RSpec.describe Rook do
  describe '#generate_horizontal_moves' do
    subject(:rook_test) { Rook.new('B', ['D', 1]) }

    context 'when its moving horizontally without obstacles' do
      it 'generates 7 possible movements' do
        result = rook_test.generate_horizontal_moves([])
        expect(result.count).to eq 7
      end
    end

    context 'when its moving horizontally with friendly obstacles 2 squares away' do
      let(:board_test) { [Rook.new('B', ['A', 1]), Rook.new('B', ['G', 1])] }

      it 'generates 4 possible movements' do
        result = rook_test.generate_horizontal_moves(board_test)
        expect(result.count).to eq 4
      end
    end

    context 'when its moving horizontally with enemy obstacles 2 squares away' do
      let(:board_test) { [Rook.new('W', ['A', 1]), Rook.new('W', ['G', 1])] }

      it 'generates 6 possible movements' do
        result = rook_test.generate_horizontal_moves(board_test)
        expect(result.count).to eq 6
      end
    end
  end
end
