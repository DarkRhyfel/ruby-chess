# frozen_string_literal: true

# Save Load module
module SaveLoad
  def save_game(data)
    puts GAME_MESSAGES[:game_save]
    File.write('./saves/new_save.json', data)
  end

  def load_game
    if File.exist?('./saves/new_save.json')
      puts GAME_MESSAGES[:game_load]
      File.read('./saves/new_save.json')
    else
      puts GAME_MESSAGES[:no_save]
      'ERROR'
    end
  end
end
