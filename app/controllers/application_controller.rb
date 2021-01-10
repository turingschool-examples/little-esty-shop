class ApplicationController < ActionController::Base
  before_action :call_github

  def call_github
    conn = Faraday.new(url: 'https://api.github.com/repos/cunninghamge/little-esty-shop')
    response = conn.get
    body = JSON.parse(response.body, symbolize_names: true)
    repo_name = body[:name]
    binding.pry
  end
end
