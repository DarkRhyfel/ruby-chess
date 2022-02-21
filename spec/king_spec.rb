# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/king'
require_relative '../lib/classes/pieces/rook'

# Tests for king piece
RSpec.describe King do # rubocop:disable Metrics/BlockLength
  subject(:king_test) { King.new('B', ['E', 2]) }

  describe '#generate_king_moves' do # rubocop:disable Metrics/BlockLength
    context 'when moving without obstacles and no enemy pieces in attack' do
      it 'generates 8 moves' do
        king_moves = king_test.generate_king_moves([])
        expect(king_moves.count).to eq 8
      end
    end

    context 'when moving without obstacles and enemy pieces in attack' do
      let(:board_test) { [Rook.new('W', ['A', 3])] }

      it 'generates 5 moves' do
        king_moves = king_test.generate_king_moves(board_test)
        expect(king_moves.count).to eq 5
      end
    end

    context 'when moving with friendly obstacles and no enemy pieces in attack' do
      let(:board_test) { [Rook.new('B', ['E', 3])] }

      it 'generates 7 moves' do
        king_moves = king_test.generate_king_moves(board_test)
        expect(king_moves.count).to eq 7
      end
    end

    context 'when moving with friendly obstacles and enemy pieces in attack' do
      let(:board_test) { [Rook.new('B', ['E', 3]), Rook.new('W', ['A', 1])] }

      it 'generates 4 moves' do
        king_moves = king_test.generate_king_moves(board_test)
        expect(king_moves.count).to eq 4
      end
    end

    context 'when moving with enemy obstacles and no enemy pieces in attack' do
      let(:board_test) { [Rook.new('W', ['E', 3]), Rook.new('W', ['A', 4])] }

      it 'generates 5 moves' do
        king_moves = king_test.generate_king_moves(board_test)
        expect(king_moves.count).to eq 5
      end
    end

    context 'when moving with enemy obstacles and enemy pieces in attack' do
      let(:board_test) { [Rook.new('W', ['E', 3]), Rook.new('W', ['A', 3])] }

      it 'generates 5 moves' do
        king_moves = king_test.generate_king_moves(board_test)
        expect(king_moves.count).to eq 5
      end
    end
  end

  describe '#valid_moves' do
    context 'when calling method for king valid moves' do
      it 'receives a call for generating the moves' do
        expect(king_test).to receive(:generate_king_moves).with([])
        king_test.valid_moves([])
      end
    end

    context 'when requesting valid moves for the king' do
      it 'generates 8 possible moves' do
        king_moves = king_test.valid_moves([])
        expect(king_moves.count).to eq 8
      end
    end
  end
end
