# frozen_string_literal: true

# External reference
require_relative '../lib/classes/pieces/queen'

# Test for Queen
RSpec.describe Queen do # rubocop:disable Metrics/BlockLength
  subject(:queen_test) { Queen.new('B', ['D', 1]) }

  describe '#move' do
    context 'when it moves horizontally' do
      it 'is a valid move' do
        result = queen_test.move(['H', 1])
        expect(result).to eq true
      end
    end

    context 'when it moves vertically' do
      it 'is a valid move' do
        result = queen_test.move(['D', 6])
        expect(result).to eq true
      end
    end

    context 'when it moves diagonally' do
      it 'is a valid move' do
        result = queen_test.move(['F', 3])
        expect(result).to eq true
      end
    end

    context 'when is an invalid position' do
      it 'is not a valid move' do
        result = queen_test.move(['X', -3])
        expect(result).to eq false
      end
    end
  end
end
