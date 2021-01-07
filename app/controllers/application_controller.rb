class ApplicationController < ActionController::Base

  def get_contributors
    response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop/contributors'
    body = response.body
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def get_repo
    response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop'
    body = response.body
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
