require 'httmultiparty'

module Platform161
  class Client

    REQUIRED_KEYS = [:user, :password, :client_id, :client_secret]

    def initialize(api_url, credentials)
      unknown_keys = credentials.keys - REQUIRED_KEYS.flatten
      raise ArgumentError, "Unknown key(s): #{unknown_keys.join(", ")}" unless unknown_keys.empty?

      @api_url = api_url
      @credentials = credentials
    end

    def request(method, resource, options = {})
      uri = "#{@api_url}/#{resource}"
      @token = get_token if @token.nil?
      header = {"PFM161-API-AccessToken" => @token}
      response = HTTMultiParty.public_send(method, uri, body: options, headers: header)
      response
    end

    private

    def get_token
      uri = "#{@api_url}/access_tokens"
      HTTMultiParty.public_send('post', uri, :body => @credentials)['token']
    end
  end
end
