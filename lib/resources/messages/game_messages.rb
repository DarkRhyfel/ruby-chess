# frozen_string_literal: true

GAME_MESSAGES = {
  welcome: "Welcome, let's play a game of chess! White moves first.",
  ask_load: "Enter '1' if you want to load a previous game or '2' if you want to start a new one",
  game_load: 'Loading saved game...',
  no_save: 'There is no saved game! Starting a new one.',
  ask_save: "Enter '1' if you want to save the game or '2' to continue playing",
  game_save: 'Saving current game...',
  request_move: 'Please enter the move you want to make in the following format: PA7-A8',
  request_invalid: 'The move requested is not in the correct format! Input another please.',
  check_message: "It's a CHECK!",
  checkmate_message: 'CHECKMATE! You win!'
}.freeze
