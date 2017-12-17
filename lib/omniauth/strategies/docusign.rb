require 'omniauth-oauth2'
require 'json'
require 'oauth2'

module OmniAuth
  module Strategies
    class Docusign < OmniAuth::Strategies::OAuth2
      SITE_URL = 'https://account.docusign.com/'
      option :name, :docusign

      option :client_options, {
        site: SITE_URL,
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token'
      }

      option :authorize_params, {
        scope: 'signature'
      }

      def encoded_auth
        Base64.strict_encode64("#{client.id}:#{client.secret}")
      end

      def callback_phase
        token_params = {
          redirect_uri: callback_url.split('?').first,
          client_id: client.id,
          client_secret: client.secret,
          headers: {'Authorization' => "Basic #{encoded_auth}"}
        }
        verifier = request.params['code']
        client.auth_code.get_token(verifier, token_params)
        super
      end

      uid { raw_info['sub'] }

      info do
        {
          'email' => raw_info['email'],
          'name' => raw_info['name'],
          'accounts' => raw_info['accounts']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        url = "/oauth/userinfo"
        @raw_info ||= access_token.get(url).parsed
      end

      def refresh_token(token, refresh_token)
        token = ::OAuth2::AccessToken.new client, token, { refresh_token: refresh_token }
        token.refresh!
      end

    end
  end
end