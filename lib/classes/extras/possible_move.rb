# frozen_string_literal: true

# Possible Move class
# Represents a piece possible move and its state
class PossibleMove
  attr_reader :id, :position, :state

  def initialize(position, state, id = 'NM')
    @id = id
    @position = position
    @state = state
  end
end
