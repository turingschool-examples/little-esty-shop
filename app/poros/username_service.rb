require 'httparty'

class UsernameService

  def usernames
    @token = "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"
    get_url("https://api.github.com/repos/jaredhardinger/little-esty-shop/collaborators", headers: {"User-Agent" => "wes30303", "Authorization" => "token #{@token}"})
  end

  def get_url(url, key)
    response = HTTParty.get(url, key)
    JSON.parse(response.body, symbolize_names: true)
  end

end
