module Teambition
  # Mix-in module to introduce Teambition APIs
  module API
    attr_accessor :token

    # Validate the token
    def valid_token?
      uri = URI.join(Teambition::API_DOMAIN, "/api/applications/#{Teambition.client_key}/tokens/check")

      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "OAuth2 #{token}"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
        https.request(req)
      end
      res.code == '200'
    end

    # @raise JSON::ParserError
    def get(path)
      uri = URI.join(API_DOMAIN, path + "?access_token=#{token}")
      JSON.parse(Net::HTTP.get(uri))
    end

    # @raise JSON::ParserError
    def post(path, params = {})
      uri = URI.join(API_DOMAIN, path + "?access_token=#{token}")

      req = Net::HTTP::Post.new(uri)
      req.set_form_data(params)

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
        https.request(req)
      end
      JSON.parse(res.body)
    end

    # @raise JSON::ParserError
    def put(path, params = {})
      uri = URI.join(API_DOMAIN, path + "?access_token=#{token}")

      req = Net::HTTP::Put.new(uri)
      req.set_form_data(params)

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
        https.request(req)
      end
      JSON.parse(res.body)
    end

    # @raise JSON::ParserError
    def delete(path)
      uri = URI.join(API_DOMAIN, path + "?access_token=#{token}")

      req = Net::HTTP::Delete.new(uri)
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
        https.request(req)
      end
      JSON.parse(res.body)
    end
  end
end
