module Teambition
  module API
    # Default attributes:
    #   @teambition_token
    #   @teambition_id

    def authorize_url(redirect_uri, state: nil, lang: :zh)
      uri = URI.join(Teambition::AUTH_DOMAIN, '/oauth2/authorize')

      params = {
        client_id: Teambition.client_key,
        redirect_uri: redirect_uri,
        lang: %w(zh en).include?(lang.to_s) ? lang : :zh
      }
      params[:state] = params if state
      uri.query = URI.encode_www_form(params)

      uri.to_s
    end

    def get_access_token(code)
      res = Net::HTTP.post_form(
        URI.join(Teambition::AUTH_DOMAIN, '/oauth2/access_token'),
        client_id: Teambition.client_key,
        client_secret: Teambition.client_secret,
        code: code
      )
      JSON.parse(res.body)['access_token']
    end

    def check_access_token(token)
      uri = URI.join(Teambition::API_DOMAIN, "/api/applications/#{Teambition.client_key}/tokens/check")

      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "OAuth2 #{token}"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|https|
        https.request(req)
      }

      res.code == '200'
    end
  end
end
