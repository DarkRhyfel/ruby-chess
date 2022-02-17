# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/pawn'

# Test for pawn piece
RSpec.describe Pawn do # rubocop:disable Metrics/BlockLength
  describe '#generate_pawn_moves' do # rubocop:disable Metrics/BlockLength
    context 'when pawn is at starting position' do
      subject(:pawn_test) { Pawn.new('W', ['D', 2]) }

      context 'and is moving without obstacles' do
        it 'generates 2 moves' do
          pawn_moves = pawn_test.generate_pawn_moves([])
          expect(pawn_moves.count).to eq 2
        end
      end

      context 'and is moving with friendly obstacles vertically and diagonally' do
        let(:board_test) { [Pawn.new('W', ['D', 3]), Pawn.new('W', ['E', 3])] }

        it 'generates 0 moves' do
          pawn_moves = pawn_test.generate_pawn_moves(board_test)
          expect(pawn_moves.count).to be_zero
        end
      end

      context 'and is moving with enemy obstacles vertically and diagonally' do
        let(:board_test) { [Pawn.new('B', ['D', 3]), Pawn.new('B', ['E', 3])] }

        it 'generates 1 move' do
          pawn_moves = pawn_test.generate_pawn_moves(board_test)
          expect(pawn_moves.count).to eq 1
        end
      end
    end

    context 'when pawn is not at starting position' do
      subject(:pawn_test) { Pawn.new('W', ['D', 4]) }

      context 'and is moving without obstacles' do
        it 'generates 1 move' do
          pawn_moves = pawn_test.generate_pawn_moves([])
          expect(pawn_moves.count).to eq 1
        end
      end

      context 'and is moving with friendly obstacles vertically and diagonally' do
        let(:board_test) { [Pawn.new('W', ['D', 5]), Pawn.new('W', ['C', 5])] }

        it 'generates 0 moves' do
          pawn_moves = pawn_test.generate_pawn_moves(board_test)
          expect(pawn_moves.count).to be_zero
        end
      end

      context 'and is moving with enemy obstacles vertically and diagonally' do
        let(:board_test) { [Pawn.new('B', ['D', 5]), Pawn.new('B', ['C', 5])] }

        it 'generates 1 move' do
          pawn_moves = pawn_test.generate_pawn_moves(board_test)
          expect(pawn_moves.count).to eq 1
        end
      end
    end
  end
end
