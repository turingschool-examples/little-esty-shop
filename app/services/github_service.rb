class GithubService
  class << self
    def repository
      get_url("/repos/haewonito/little-esty-shop")
    end

    def users
      get_url("/repos/haewonito/little-esty-shop/contributors")
    end

    def get_url(url)
      response = conn.get(url)
      parse_data(response)
    end

    private
    def conn
      Faraday.new("https://api.github.com")
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
