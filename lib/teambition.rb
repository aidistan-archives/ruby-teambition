require 'json'
require 'net/http'
require 'uri'

require 'teambition/api'
require 'teambition/has_teambition_account'
require 'teambition/version'

# Top-level namespace
module Teambition
  # Authorization domain
  AUTH_DOMAIN = 'https://account.teambition.com'.freeze
  # API domain
  API_DOMAIN = 'https://api.teambition.com'.freeze

  class << self
    # Client key provided by Teambition
    attr_accessor :client_key
    # Client secret provided by Teambition
    attr_accessor :client_secret
    # Customizable callback url
    attr_accessor :callback_url

    # Get the url for authorization
    # @param state [String]
    # @param lang [String/Symbol]
    # @return [String]
    def authorize_url(state: nil, lang: :zh)
      uri = URI.join(AUTH_DOMAIN, '/oauth2/authorize')

      params = {
        client_id: client_key,
        redirect_uri: callback_url,
        lang: %w[zh en].include?(lang.to_s) ? lang : :zh
      }
      params[:state] = state if state
      uri.query = URI.encode_www_form(params)

      uri.to_s
    end

    # Fetch the access token by a code
    # @param code [String]
    # @return [String]
    def get_access_token(code)
      res = Net::HTTP.post_form(
        URI.join(AUTH_DOMAIN, '/oauth2/access_token'),
        client_id: client_key,
        client_secret: client_secret,
        code: code
      )
      JSON.parse(res.body)['access_token']
    end

    # Validate the token
    # @param token [String]
    def valid_access_token?(token)
      uri = URI.join(API_DOMAIN, "/api/applications/#{client_key}/tokens/check")

      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "OAuth2 #{token}"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
        https.request(req)
      end
      res.code == '200'
    end
  end
end
