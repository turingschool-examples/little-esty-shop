module ApplicationHelper
  def format_time
  end

  def user_name
    response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/contributors")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    parsed_json.map{|user| user[:login]}
  end

  def repo_name
    response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    parsed_json[:full_name]
  end

  def pull_request
    response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/pulls?state=closed")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    parsed_json.count
  end

  def commits
  response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/commits")
  parsed_json = JSON.parse(response.body, symbolize_names: true)
  # hash = Hash.new(0)
  # parsed_json.each do |commit|
  #   hash[commit[:author][:login]] +=1
  # end 
  # parsed_json[:commit]
  # binding.prys
  end
end
