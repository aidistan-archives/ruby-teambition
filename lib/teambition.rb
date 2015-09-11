require 'json'
require 'net/http'
require 'uri'

require 'teambition/api'
require 'teambition/version'

module Teambition
  AUTH_DOMAIN  = 'https://account.teambition.com'
  API_DOMAIN   = 'https://api.teambition.com'

  class << self
    attr_accessor :client_key
    attr_accessor :client_secret
    attr_accessor :callback_url
  end
end
