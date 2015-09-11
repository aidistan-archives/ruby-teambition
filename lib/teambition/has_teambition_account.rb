require 'active_support'

module Teambition
  module HasTeambitionAccout
    extend ActiveSupport::Concern

    included do
    end

    class_methods do
      def has_teambition_account(token: :token, namespace: :tb)
        fail ArgumentError unless token

        unless namespace
          include Teambition::API
          define_method(:token) { self.send(token) } unless token == :token
          return
        end

        kclass = Class.new do
          include Teambition::API

          def initialize(obj, msg)
            @obj = obj
            @msg = msg
          end

          def token
            @obj.send(@msg)
          end
        end

        define_method(namespace) do
          @tb || kclass.new(self, token)
        end
      end
    end
  end
end
