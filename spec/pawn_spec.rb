# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/pawn'

# Test for pawn piece
RSpec.describe Pawn do # rubocop:disable Metrics/BlockLength
  describe '#valid_pawn_move' do # rubocop:disable Metrics/BlockLength
    context 'using the white set' do # rubocop:disable Metrics/BlockLength
      subject(:pawn_test_white) { Pawn.new('W', ['B', 2]) }

      context 'when is moving forward 1 square' do
        it 'is a valid move' do
          result = pawn_test_white.valid_pawn_move(['B', 3])
          expect(result).to eq true
        end
      end

      context 'when is moving forward 2 squares at the start' do
        it 'is a valid move' do
          result = pawn_test_white.valid_pawn_move(['B', 4])
          expect(result).to eq true
        end
      end

      context 'when moving forward more than 1 square' do
        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['B', 6])
          expect(result).to eq false
        end
      end

      context 'when moving forward more than 2 squares after the start' do
        subject(:pawn_test_white) { Pawn.new('W', ['B', 3]) }

        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['B', 5])
          expect(result).to eq false
        end
      end

      context 'when moving diagonally more than 1 square' do
        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['D', 4])
          expect(result).to eq false
        end
      end

      context 'when moving horizontally' do
        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['C', 2])
          expect(result).to eq false
        end
      end

      context 'when moving backwards' do
        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['B', 1])
          expect(result).to eq false
        end
      end

      context 'when moving out of the board' do
        it 'is not a valid move' do
          result = pawn_test_white.valid_pawn_move(['Y', 11])
          expect(result).to eq false
        end
      end
    end

    context 'using the black set' do # rubocop:disable Metrics/BlockLength
      subject(:pawn_test_black) { Pawn.new('B', ['B', 7]) }

      context 'when is moving forward 1 square' do
        it 'is a valid move' do
          result = pawn_test_black.valid_pawn_move(['B', 6])
          expect(result).to eq true
        end
      end

      context 'when is moving forward 2 squares at the start' do
        it 'is a valid move' do
          result = pawn_test_black.valid_pawn_move(['B', 5])
          expect(result).to eq true
        end
      end

      context 'when moving forward more than 1 square' do
        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['B', 3])
          expect(result).to eq false
        end
      end

      context 'when moving forward more than 2 squares after the start' do
        subject(:pawn_test_black) { Pawn.new('B', ['B', 6]) }

        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['B', 4])
          expect(result).to eq false
        end
      end

      context 'when moving diagonally more than 1 square' do
        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['D', 5])
          expect(result).to eq false
        end
      end

      context 'when moving horizontally' do
        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['C', 7])
          expect(result).to eq false
        end
      end

      context 'when moving backwards' do
        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['B', 8])
          expect(result).to eq false
        end
      end

      context 'when moving out of the board' do
        it 'is not a valid move' do
          result = pawn_test_black.valid_pawn_move(['A', -1])
          expect(result).to eq false
        end
      end
    end
  end
end
