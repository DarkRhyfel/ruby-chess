# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/rook'

# Tests for Rook class and it's methods
RSpec.describe Rook do # rubocop:disable Metrics/BlockLength
  subject(:rook_test) { Rook.new('B', ['A', 1]) }

  describe '#valid_horizontal_move' do
    context 'when is changing only of column' do
      it 'is a valid move' do
        result = rook_test.valid_horizontal_move(['A', 2])
        expect(result).to eq true
      end
    end

    context 'when is changing of row' do
      it 'is not a valid move' do
        result = rook_test.valid_horizontal_move(['B', 2])
        expect(result).to eq false
      end
    end

    context 'when the column is not a valid tile' do
      it 'is not a valid move' do
        result = rook_test.valid_horizontal_move(['A', 9])
        expect(result).to eq false
      end
    end
  end

  describe '#valid_vertical_move' do
    context 'when is changing only of row' do
      it 'is a valid move' do
        result = rook_test.valid_vertical_move(['B', 1])
        expect(result).to eq true
      end
    end

    context 'when is changing of column' do
      it 'is not a valid move' do
        result = rook_test.valid_vertical_move(['B', 2])
        expect(result).to eq false
      end
    end

    context 'when the row is not a valid tile' do
      it 'is not a valid move' do
        result = rook_test.valid_vertical_move(['K', 1])
        expect(result).to eq false
      end
    end
  end
end
