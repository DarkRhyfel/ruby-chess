# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/king'

# Tests for king piece
RSpec.describe King do # rubocop:disable Metrics/BlockLength
  subject(:king_test) { King.new('B', ['E', 1]) }

  describe '#valid_king_move' do # rubocop:disable Metrics/BlockLength
    context 'when changing its row by 1' do
      it 'is a valid move' do
        result = king_test.valid_king_move(['E', 2])
        expect(result).to eq true
      end
    end

    context 'when changing its column by 1' do
      it 'is a valid move' do
        result = king_test.valid_king_move(['D', 1])
        expect(result).to eq true
      end
    end

    context 'when changing its row and column by 1' do
      it 'is a valid move' do
        result = king_test.valid_king_move(['D', 2])
        expect(result).to eq true
      end
    end

    context 'when changing its row by more than 1' do
      it 'is not a valid move' do
        result = king_test.valid_king_move(['D', 5])
        expect(result).to eq false
      end
    end

    context 'when changing its column by more than 1' do
      it 'is not a valid move' do
        result = king_test.valid_king_move(['A', 1])
        expect(result).to eq false
      end
    end

    context 'when changing both column and row by more than 1' do
      it 'is not a valid move' do
        result = king_test.valid_king_move(['G', 3])
        expect(result).to eq false
      end
    end

    context 'when tile is out of the board' do
      it 'is not a valid move' do
        result = king_test.valid_king_move(['Z', -9])
        expect(result).to eq false
      end
    end
  end

  describe '#move' do
    context 'when moving inside the boundaries' do
      it 'is a valid move' do
        result = king_test.move(['E', 2])
        expect(result).to eq true
      end
    end

    context 'when moving outside tbe boundaries' do
      it 'is not a valid move' do
        result = king_test.move(['E', -1])
        expect(result).to eq false
      end
    end
  end
end
