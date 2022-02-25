# frozen_string_literal: true

# External references
require_relative '../lib/classes/game/game_logic'

# Test for Game Logic class and its methods
RSpec.describe GameLogic do # rubocop:disable Metrics/BlockLength
  subject(:game_logic_test) { GameLogic.new }

  describe '#turn' do # rubocop:disable Metrics/BlockLength
    context 'when inputing an invalid move request' do # rubocop:disable Metrics/BlockLength
      let(:error_message) { 'The move requested is not in the correct format! Input another please.' }

      context 'like 3 characters' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PB3')
        end

        it 'returns an error message' do
          expect(game_logic_test).to receive(:puts).with(error_message).once
          game_logic_test.turn
        end
      end

      context 'like 8 characters' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PB3-toB4')
        end

        it 'returns an error message' do
          expect(game_logic_test).to receive(:puts).with(error_message).once
          game_logic_test.turn
        end
      end

      context 'like invalid columns' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PT4-U8')
        end

        it 'returns an error message' do
          expect(game_logic_test).to receive(:puts).with(error_message).once
          game_logic_test.turn
        end
      end

      context 'like invalid rows' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PA9-H0')
        end

        it 'returns an error message' do
          expect(game_logic_test).to receive(:puts).with(error_message).once
          game_logic_test.turn
        end
      end

      context 'and returning the invocation' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PO9-A4')
        end

        it 'returns false' do
          turn_result = game_logic_test.turn
          expect(turn_result).to eq false
        end
      end
    end

    context 'when inputting a valid move request' do # rubocop:disable Metrics/BlockLength
      context 'and before moving forward' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PA2-A5')
          allow(game_logic_test).to receive(:check_move_result)
        end

        it 'request a check for a valid move' do
          board = game_logic_test.instance_variable_get(:@game_board)
          expect(board).to receive(:move_piece).with('W', ['A', 2], ['A', 5])
          game_logic_test.turn
        end
      end

      context 'but is not a valid move for the piece' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PA2-A5')
        end

        it 'shows an error message' do
          error_message = "The piece you selected can't move to that position! Select another."
          expect(game_logic_test).to receive(:puts).with(error_message)
          game_logic_test.turn
        end

        it 'returns false' do
          turn_result = game_logic_test.turn
          expect(turn_result).to eq false
        end
      end

      context 'and is a valid move' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:gets).and_return('PA2-A4')
        end

        it 'changes the current player' do
          game_logic_test.turn
          current_player = game_logic_test.instance_variable_get(:@current_player)
          expect(current_player).to eq 'B'
        end

        it 'changes the enemy player' do
          game_logic_test.turn
          enemy_player = game_logic_test.instance_variable_get(:@enemy_player)
          expect(enemy_player).to eq 'W'
        end

        it 'returns true' do
          turn_result = game_logic_test.turn
          expect(turn_result).to eq true
        end
      end
    end
  end

  describe '#play' do # rubocop:disable Metrics/BlockLength
    context 'when starting a new game' do # rubocop:disable Metrics/BlockLength
      context 'requests a player move' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:draw_board)
          allow(game_logic_test).to receive(:turn).and_return(true)

          board = game_logic_test.instance_variable_get(:@game_board)
          allow(board).to receive(:verify_check_status).and_return(:checkmate)
        end

        it 'calls for a turn once if entered correctly' do
          expect(game_logic_test).to receive(:turn).once
          game_logic_test.play
        end
      end

      context 'requests a player move repeteadly' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:draw_board)
          allow(game_logic_test).to receive(:turn).and_return(false, false, true)

          board = game_logic_test.instance_variable_get(:@game_board)
          allow(board).to receive(:verify_check_status).and_return(:checkmate)
        end

        it 'calls for a turn three times' do
          expect(game_logic_test).to receive(:turn).exactly(3).times
          game_logic_test.play
        end
      end

      context 'and player move does not produce a check' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:draw_board)
          allow(game_logic_test).to receive(:turn).and_return(true)

          board = game_logic_test.instance_variable_get(:@game_board)
          allow(board).to receive(:verify_check_status).and_return(:no_check)
        end

        it 'continues the game' do
          expect(game_logic_test).to receive(:puts).once
          game_logic_test.play
        end
      end

      context 'and player move produces a check' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:draw_board)
          allow(game_logic_test).to receive(:turn).and_return(true)

          board = game_logic_test.instance_variable_get(:@game_board)
          allow(board).to receive(:verify_check_status).and_return(:check)
        end

        it 'shows a message for a check' do
          check_message = "It's a CHECK!"
          expect(game_logic_test).to receive(:puts).with(check_message)
          game_logic_test.play
        end
      end

      context 'and player move produces a checkmate' do
        before do
          allow(game_logic_test).to receive(:puts)
          allow(game_logic_test).to receive(:draw_board)
          allow(game_logic_test).to receive(:turn).and_return(true)

          board = game_logic_test.instance_variable_get(:@game_board)
          allow(board).to receive(:verify_check_status).and_return(:checkmate)
        end

        it 'shows a message for a checkmate' do
          checkmate_message = 'CHECKMATE! You win!'
          expect(game_logic_test).to receive(:puts).with(checkmate_message)
          game_logic_test.play
        end
      end
    end
  end
end
