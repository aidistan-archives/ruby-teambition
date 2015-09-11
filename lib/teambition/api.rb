module Teambition
  module API
    # Default attributes:
    #   @teambition_token
    #   @teambition_id

    def authorize_url(redirect_uri, state: nil, lang: :zh)
      uri = URI.join(Teambition::AUTH_DOMAIN, 'oauth2/authorize')

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
        URI.join(Teambition::AUTH_DOMAIN, 'oauth2/access_token'),
        client_id: Teambition.client_key,
        client_secret: Teambition.client_secret,
        code: code
      )
      JSON.parse(res.body)['access_token']
    end
  end
end
