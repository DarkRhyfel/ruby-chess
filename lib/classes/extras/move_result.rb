# frozen_string_literal: true

# Move Result class
# Represents the result of a move request
class MoveResult
  include Comparable

  attr_reader :state, :message

  def initialize(state, message)
    @state = state
    @message = message
  end

  def <=>(other)
    state <=> other.state && message <=> other.message
  end
end
