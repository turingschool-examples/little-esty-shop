class GitHubAPI 
    def get_data(end_point)
        response = HTTParty.get("https://api.github.com/users/okayama-mayu#{end_point}"
        data = response.body 
        json = Json.parse(data, symbolize_names: true)
    end

    def usernames 
        get_data("/contributers")
    end
end
