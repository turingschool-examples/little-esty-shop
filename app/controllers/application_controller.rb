class ApplicationController < ActionController::Base
  def welcome
  end

  before_action :repo_info

  def repo_info
    conn = Faraday.new(url: "https://api.github.com")

    reponame = conn.get("/repos/nickjacobsss/little-esty-shop")
    @data = JSON.parse(reponame.body, symbolize_names: true)

    contributors = conn.get("/repos/nickjacobsss/little-esty-shop/contributors")
    @data2 = JSON.parse(contributors.body, symbolize_names: true)

    pullrequests = conn.get("/repos/nickjacobsss/little-esty-shop/pulls?state=closed")
    @data3 = JSON.parse(pullrequests.body, symbolize_names: true)

  end
end
