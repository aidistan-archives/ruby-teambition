require 'active_support'

module Teambition
  # Model-based mix-in module, built on ActiveSupport::Concern
  module HasTeambitionAccout
    extend ActiveSupport::Concern

    # @!method has_teambition_account(token: :teambition_token, namespace: :tb)
    #   Macro for mixing-in Teambition API
    #   @param token [Symbol] the attribute storing the token in current namespace
    #   @param namespace [Symbol] a name of the namespace which to include Teambition APIs (+nil+ to include directly in current namespace)

    included do
    end

    class_methods do
      # rubocop:disable Style/PredicateName
      def has_teambition_account(token: :teambition_token, namespace: :tb)
        raise ArgumentError unless token

        if namespace
          define_method(namespace) do
            @__teambition_namespace__ ||= Teambition::Wrapper.new(self, token)
          end
        else
          include Teambition::API
          define_method(:token) { send(token) } unless token == :token
        end
      end
      # rubocop:enable Style/PredicateName
    end
  end
end
