module APIS
  class RenderRequest
    attr_reader :endpoint, :endpoint_arr

    def initialize(endpoint)
      if endpoint.class == String
        @endpoint = endpoint
      else
        @endpoint_arr = endpoint.values
      end
    end

    def parse
      if !@endpoint.nil?
        request = API.make_request(@endpoint)
        request.class == String ? JSON.parse(request) : JSON.parse(request.body)
      else
        @endpoint_arr.map do |endpoint|
          request = API.make_request(endpoint)
          request.class == String ? JSON.parse(request) : JSON.parse(request.body)
        end.flatten
      end
    end

  end
end
