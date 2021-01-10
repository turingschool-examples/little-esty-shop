class GithubApiController < ApplicationController
  def show
    # connection = Faraday.new('https://api.github.com')
    # response   = connection.get('/repos/foymikek/little-esty-shop/stats/contributors')
    # results = JSON.parse(response.body, symbolize_names: true)
    # @github_results = results.map do |user_data|
    #   GithubResults.new(user_data)
    # end
    @github_results = GithubFacade.get_users
  end
end