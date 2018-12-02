module Teambition
  # Namespace wrapper for Teambition::API to keep outside clean
  class Wrapper
    include Teambition::API

    # Create a delegator
    # @param obj [Object] object to delegate
    # @param msg [Symbol] method of +obj+ returning the teambition token
    def initialize(obj, msg)
      @obj = obj
      @msg = msg
    end

    # Delegate method for the teambition token
    def token
      @obj.send(@msg)
    end
  end
end
