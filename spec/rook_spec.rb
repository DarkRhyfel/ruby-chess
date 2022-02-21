# frozen_string_literal: true

# External references
require_relative '../lib/classes/pieces/rook'

# Tests for Rook class and it's methods
RSpec.describe Rook do # rubocop:disable Metrics/BlockLength
  describe '#generate_horizontal_moves' do
    subject(:rook_test) { Rook.new('B', ['D', 1]) }

    context 'when its moving horizontally without obstacles' do
      it 'generates 7 possible moves' do
        horizontal_moves = rook_test.generate_horizontal_moves([])
        expect(horizontal_moves.count).to eq 7
      end
    end

    context 'when its moving horizontally with friendly obstacles 2 squares away' do
      let(:board_test) { [Rook.new('B', ['A', 1]), Rook.new('B', ['G', 1])] }

      it 'generates 4 possible moves' do
        horizontal_moves = rook_test.generate_horizontal_moves(board_test)
        expect(horizontal_moves.count).to eq 4
      end
    end

    context 'when its moving horizontally with enemy obstacles 2 squares away' do
      let(:board_test) { [Rook.new('W', ['A', 1]), Rook.new('W', ['G', 1])] }

      it 'generates 6 possible moves' do
        horizontal_moves = rook_test.generate_horizontal_moves(board_test)
        expect(horizontal_moves.count).to eq 6
      end
    end
  end

  describe '#generate_vertical_moves' do
    subject(:rook_test) { Rook.new('B', ['F', 7]) }

    context 'when its moving vertically without obstacles' do
      it 'generates 7 possible moves' do
        vertical_moves = rook_test.generate_vertical_moves([])
        expect(vertical_moves.count).to eq 7
      end
    end

    context 'when its moving vertically with friendly obstacles 2 squares away' do
      let(:board_test) { [Rook.new('B', ['F', 4])] }

      it 'generates 3 possible moves' do
        vertical_moves = rook_test.generate_vertical_moves(board_test)
        expect(vertical_moves.count).to eq 3
      end
    end

    context 'when its moving horizontally with enemy obstacles 2 squares away' do
      let(:board_test) { [Rook.new('W', ['F', 4])] }

      it 'generates 4 possible moves' do
        vertical_moves = rook_test.generate_vertical_moves(board_test)
        expect(vertical_moves.count).to eq 4
      end
    end
  end

  describe '#valid_moves' do
    subject(:rook_test) { Rook.new('B', ['E', 4]) }

    context 'when calling the method to check valid moves' do
      before do
        allow(rook_test).to receive(:generate_horizontal_moves).and_return([PossibleMove.new(['D', 4], false, 'H1')])
        allow(rook_test).to receive(:generate_vertical_moves).and_return([PossibleMove.new(['E', 5], false, 'H1')])
      end

      it 'receives a call for horizontal moves' do
        expect(rook_test).to receive(:generate_horizontal_moves).with([])
        rook_test.valid_moves([])
      end

      it 'receives a call for vertical moves' do
        expect(rook_test).to receive(:generate_vertical_moves).with([])
        rook_test.valid_moves([])
      end
    end

    context 'when requesting the valid moves of the rook' do
      it 'generates 14 possibles moves' do
        possible_moves = rook_test.valid_moves([])
        expect(possible_moves.count).to eq 14
      end
    end
  end
end
