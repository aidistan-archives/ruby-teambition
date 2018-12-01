module Teambition
  # Namespace wrapper for Teambition::API to keep outside clean
  class Wrapper
    include Teambition::API

    def initialize(obj, msg)
      @obj = obj
      @msg = msg
    end

    def token
      @obj.send(@msg)
    end
  end
end
