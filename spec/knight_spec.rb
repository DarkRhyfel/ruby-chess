# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/knight'

# Test for knight piece
RSpec.describe Knight do # rubocop:disable Metrics/BlockLength
  subject(:knight_test) { Knight.new('B', ['B', 1]) }

  describe '#valid_knight_move' do # rubocop:disable Metrics/BlockLength
    context 'when is moving 2 squares vertically and 1 horizontally' do
      it 'is a valid move' do
        result = knight_test.valid_knight_move(['C', 3])
        expect(result).to eq true
      end
    end

    context 'when is moving two squares horizontally and 1 vertically' do
      it 'is a valid move' do
        result = knight_test.valid_knight_move(['D', 2])
        expect(result).to eq true
      end
    end

    context 'when is only changing its column' do
      it 'is not a valid move' do
        result = knight_test.valid_knight_move(['E', 1])
        expect(result).to eq false
      end
    end

    context 'when is only changing its row' do
      it 'is not a valid move' do
        result = knight_test.valid_knight_move(['B', 6])
        expect(result).to eq false
      end
    end

    context 'when is changing bot row and column' do
      it 'is not a valid move' do
        result = knight_test.valid_knight_move(['E', 4])
        expect(result).to eq false
      end
    end

    context 'when is going out of the board' do
      it 'is not a valid move' do
        result = knight_test.valid_knight_move(['O', 9])
        expect(result).to eq false
      end
    end
  end

  describe '#move' do # rubocop:disable Metrics/BlockLength
    context 'when is moving as a knight' do
      it 'is a valid move' do
        result = knight_test.move(['A', 3])
        expect(result).to eq true
      end
    end

    context 'when is moving horizontally' do
      it 'is not a valid move' do
        result = knight_test.move(['G', 1])
        expect(result).to eq false
      end
    end

    context 'when is moving vertically' do
      it 'is not a valid move' do
        result = knight_test.move(['B', 8])
        expect(result).to eq false
      end
    end

    context 'when is moving diagonally' do
      it 'is not a valid move' do
        result = knight_test.move(['C', 2])
        expect(result).to eq false
      end
    end

    context 'when is an invalid tile' do
      it 'is not a valid move' do
        result = knight_test.move(['Z', 11])
        expect(result).to eq false
      end
    end
  end
end
