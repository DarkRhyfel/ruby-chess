# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/knight'

# Test for knight piece
RSpec.describe Knight do # rubocop:disable Metrics/BlockLength
  subject(:knight_test) { Knight.new('B', ['E', 4]) }

  describe '#generate_knight_moves' do
    context 'when is moving without obstacles' do
      it 'generates 8 moves' do
        knight_moves = knight_test.generate_knight_moves([])
        expect(knight_moves.count).to eq 8
      end
    end

    context 'when is moving and friendly pieces are in its way' do
      let(:board_test) { [Knight.new('B', ['D', 6]), Knight.new('B', ['G', 3])] }

      it 'generates 6 moves' do
        knight_moves = knight_test.generate_knight_moves(board_test)
        expect(knight_moves.count).to eq 6
      end
    end

    context 'when is moving and enemy pieces are in its way' do
      let(:board_test) { [Knight.new('W', ['D', 6]), Knight.new('W', ['G', 3])] }

      it 'generates 8 moves' do
        knight_moves = knight_test.generate_knight_moves(board_test)
        expect(knight_moves.count).to eq 8
      end
    end
  end

  describe '#valid_moves' do
    context 'when calling the method for knight valid moves' do
      it 'requests the knight moves' do
        expect(knight_test).to receive(:generate_knight_moves).with([])
        knight_test.valid_moves([])
      end
    end

    context 'when requesting the knight valid moves' do
      it 'generates 8 possible moves' do
        knight_moves = knight_test.valid_moves([])
        expect(knight_moves.count).to eq 8
      end
    end
  end
end
