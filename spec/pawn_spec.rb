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

  describe '#valid_moves' do # rubocop:disable Metrics/BlockLength
    context 'when calling the method for valid pawn moves' do
      subject(:pawn_test) { Pawn.new('W', ['D', 2]) }

      it 'calls the method to generate moves' do
        expect(pawn_test).to receive(:generate_pawn_moves).with([])
        pawn_test.valid_moves([])
      end
    end

    context 'when requesting valid moves for white pawn' do
      subject(:pawn_test) { Pawn.new('W', ['D', 2]) }
      let(:board_test) { [Pawn.new('W', ['E', 3])] }

      it 'generates 2 possible moves' do
        pawn_moves = pawn_test.valid_moves(board_test)
        expect(pawn_moves.count).to eq 2
      end

      it 'contains an specific list of positions' do
        pawn_moves = pawn_test.valid_moves(board_test)
        expect(pawn_moves).to eq [[['D', 3], false], [['D', 4], false]]
      end
    end

    context 'when requesting valid moves for black pawn' do
      subject(:pawn_test) { Pawn.new('B', ['C', 6]) }
      let(:board_test) { [Pawn.new('W', ['B', 5])] }

      it 'generates 2 possible moves' do
        pawn_moves = pawn_test.valid_moves(board_test)
        expect(pawn_moves.count).to eq 2
      end

      it 'contains an specific list of positions' do
        pawn_moves = pawn_test.valid_moves(board_test)
        expect(pawn_moves).to eq [[['C', 5], false], [['B', 5], true]]
      end
    end
  end
end
