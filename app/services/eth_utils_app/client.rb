require 'net/http'

module EthUtilsApp
  class Client
    attr_reader :host, :port

    def initialize
      @host = 'eth_utils_app'
      @port = 3000
    end
  
    def get(endpoint)
      request = Net::HTTP::Get.new('/' + endpoint, headers)
      response = http.request(request)
      handle(response)
    end
  
    private
  
    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  
    def http
      http = Net::HTTP.new(host, port)
      http.read_timeout = 60 * 5
      http
    end
  
    def handle(response)
      case response
      when Net::HTTPOK
        JSON.parse(response.body)
      else
        error = JSON.parse(response.body)
        raise StandardError, error.dig('errors') if error.dig('errors')
      end
    end
  end
end
