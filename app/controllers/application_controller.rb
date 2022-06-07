class ApplicationController < ActionController::Base
  def welcome
  end

  before_action :repo_info

  def repo_info
    conn = Faraday.new(url: "https://api.github.com")

    response = conn.get("/repos/nickjacobsss/little-esty-shop")
    @data = JSON.parse(response.body, symbolize_names: true)

    response2 = conn.get("/repos/nickjacobsss/little-esty-shop/contributors")
    @data2 = JSON.parse(response2.body, symbolize_names: true)
  end
end
