module APIS
  class RenderRequest

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def parse
      request = API.make_request(@endpoint)
      request.class == String ? JSON.parse(request) : JSON.parse(request.body)
    end

  end
end
