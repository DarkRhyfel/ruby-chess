# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/bishop'

# Tests for Bishop
RSpec.describe Bishop do # rubocop:disable Metrics/BlockLength
  subject(:bishop_test) { Bishop.new('B', ['D', 4]) }

  describe '#generate_diagonal_moves' do # rubocop:disable Metrics/BlockLength
    context 'when its moving without obstacles' do
      it 'generates 13 moves' do
        result = bishop_test.generate_diagonal_moves([])
        expect(result.count).to eq 13
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
        result = bishop_test.generate_diagonal_moves(board_test)
        expect(result.count).to eq 8
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
        result = bishop_test.generate_diagonal_moves(board_test)
        expect(result.count).to eq 12
      end
    end
  end
end
