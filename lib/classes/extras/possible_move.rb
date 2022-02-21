# frozen_string_literal: true

# Possible Move class
# Represents a piece possible move and its state
class PossibleMove
  include Comparable

  attr_reader :id, :position, :state

  def initialize(position, state, id = 'NM')
    @id = id
    @position = position
    @state = state
  end

  def <=>(other)
    id <=> other.id && position <=> other.position && state <=> other.state
  end

  def eql?(other)
    position == other.position
  end
end
