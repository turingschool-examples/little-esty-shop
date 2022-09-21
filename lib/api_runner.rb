require 'httparty'
require 'json'

# require './lib/film'
# require './lib/ghibili_service'

response = HTTParty.get("https://api.github.com/repos/Rileybmcc/little-esty-shop/#{stephenfabian}/commits')
# response = HTTParty.get("https://ghibliapi.herokuapp.com/films")
# response = HTTParty.get("https://ghibliapi.herokuapp.com/people")

parsed = JSON.parse(response.body, symbolize_names: true)

# parsed.each do |film|

# parsed = GithubService.get_films

# films = parsed.map do |film|
#   Film.new(film)
# end


require 'pry'; binding.pry


  # def repo_data
  #   get_url('https://api.github.com/repos/Rileybmcc/little-esty-shop')
  # end

  # def commits_data
  #   get_url('https://api.github.com/repos/Rileybmcc/little-esty-shop/commits')
  # end