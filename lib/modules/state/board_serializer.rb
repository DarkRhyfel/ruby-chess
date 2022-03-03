# frozen_string_literal: true

# Board serializer module
# Provides methods to serialize a board object
module BoardSerializer
  def serialize
    {
      '@board_state' => @board_state.map do |piece|
        {
          'type' => piece.class.name,
          '@color' => piece.color,
          '@position' => piece.position
        }
      end
    }
  end

  def deserialize(hash)
    hash.each do |variable, value|
      if variable == '@board_state'
        value = value.map { |piece| Object.const_get(piece['type']).new(piece['@color'], piece['@position']) }
      end

      instance_variable_set variable, value
    end
  end
end
