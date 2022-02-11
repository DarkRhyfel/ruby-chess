# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/bishop'

# Tests for Bishop
RSpec.describe Bishop do # rubocop:disable Metrics/BlockLength
  subject(:bishop_test) { Bishop.new('B', ['C', 1]) }

  describe '#valid_diagonal_move' do # rubocop:disable Metrics/BlockLength
    context 'when is changing both row and column' do
      it 'is a valid move' do
        result = bishop_test.valid_diagonal_move(['D', 2])
        expect(result).to eq true
      end
    end

    context 'when is changing only row' do
      it 'is not a valid move' do
        result = bishop_test.valid_diagonal_move(['C', 2])
        expect(result).to eq false
      end
    end

    context 'when is changing only column' do
      it 'is not a valid move' do
        result = bishop_test.valid_diagonal_move(['D', 1])
        expect(result).to eq false
      end
    end

    context 'when the row is an invalid tile' do
      it 'is not a valid move' do
        result = bishop_test.valid_diagonal_move(['D', 9])
        expect(result).to eq false
      end
    end

    context 'when the column is an invalid tile' do
      it 'is not a valid move' do
        result = bishop_test.valid_diagonal_move(['O', 3])
        expect(result).to eq false
      end
    end
  end
end
