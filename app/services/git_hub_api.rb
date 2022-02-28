class GitHubApi
    def initialize(token= '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') 
        @token = token
        @conn = connect
    end

    def connect 
        Faraday.new(
        url: 'https://api.github.com',
        headers: {
          'Authorization' => "token #{@token}",
        }
      )
    end

    def pull_requests
        response = @conn.get("/repos/stevenjames-turing/little-esty-shop/pulls?state=closed")
        github = JSON.parse(response.body, :symbolize_names => true)
        binding.pry
    end

    def collaborators 
        response = @conn.get("/repos/stevenjames-turing/little-esty-shop/collaborators")
        github = JSON.parse(response.body, :symbolize_names => true)
        binding.pry
    end


end