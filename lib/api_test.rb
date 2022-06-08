require 'httparty'
require 'pry'
require 'json'

response = HTTParty.get("https://api.github.com/repos/ColinReinhart/little-esty-shop/contributors")
test = JSON.parse(response.body, symbolize_names: true)

expected = ["ColinReinhart", "StephenWilkens", "CoryBethune", "tjhaines-cap", "devAndrewK"]
urls = []
test.each do |hash|
  if expected.include?(hash[:login])
    urls << hash[:avatar_url]
  end
end
return url
# this will get me all the avatar urls in an array
binding.pry
