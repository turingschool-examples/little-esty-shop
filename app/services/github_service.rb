require 'httparty'
require 'json'

class GithubService

  def self.get_repos
    # return {name: 'little-esty-shop - TEST', full_name: 'Penitent0/little-esty-shop'} if Rails.env == 'test'
    get_uri('https://api.github.com/repos/Penitent0/little-esty-shop')
  end

  def self.get_total_pulls
    # return {total_count: 999} if Rails.env == 'test'
    get_uri('https://api.github.com/search/issues?q=repo:Penitent0/little-esty-shop%20type:pr%20is:merged')
  end

  def self.get_contributors
    # return [{login: 'Ken - TEST', contributions: 999}, {login: 'Erik - TEST', contributions: 999}, {login: 'Sandy - TEST', contributions: 999}, {login: 'Aleisha - TEST', contributions: 999}] if Rails.env == 'test'
    get_uri('https://api.github.com/repos/Penitent0/little-esty-shop/contributors')
  end

  def self.get_uri(uri)
    data = HTTParty.get(uri, headers: {authorization: "Bearer "+ENV["KENTOKEN"]})
    parsed = JSON.parse(data.body, symbolize_names: true)
  end
end
