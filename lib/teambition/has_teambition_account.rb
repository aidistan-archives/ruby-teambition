require 'active_support'

module Teambition
  # Model-based mix-in module, built on ActiveSupport::Concern
  module HasTeambitionAccout
    extend ActiveSupport::Concern

    # @!method self.has_teambition_account(token: :teambition_token, namespace: :tb)
    #   Macro to mix-in Teambition APIs
    #   @param token [Symbol] attribute returning the teambition token in current namespace
    #   @param namespace [Symbol] name of the namespace which to include Teambition APIs,
    #     use +nil+ to include directly in current namespace

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
