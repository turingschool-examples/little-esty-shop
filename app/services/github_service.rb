# require 'httparty'
# require 'json'
# require 'pry'

# class GithubService
#   attr_reader :allastair, :braxton, :christian, :anthony
#   def initialize
#     @alastair = 0
#     @braxton = 0
#     @christian = 0
#     @anthony = 0
#   end
  # def repo_name
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop")
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   parsed_json[:full_name]
  # end
  
  # def user_name
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/contributors")
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   parsed_json.map{|user| user[:login]}
  # end

  # def pull_request
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/pulls?state=closed")
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   parsed_json.count
  # end

  # def commits
  # @user_names = nil
  # def get_names
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/contributors")
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   @user_names = parsed_json.map{|user| user[:login]}
  # end

  #   @commits = []
  #   def get_commits
  #     loop.with_index do |_, page_count|
  #       response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/commits?per_page=100&page=#{page_count + 1}")
  #       parsed_json = JSON.parse(response.body, symbolize_names: true)
  #       @commits << parsed_json
  #       if response.count < 100
  #         @commits.flatten!
  #         break
  #       end
  #     end
  #   end

  #   def commit_count
  #     hash = {}
  #     @commits.each do |commit|
  #       if commit[:author].nil?
  #       else
  #         if @user_names.include? commit[:author][:login]
  #           hash[commit[:author][:login].to_sym] ||= 0
  #           hash[commit[:author][:login].to_sym] += 1
  #         end
  #       end
  #     end
  #     hash
  #   end
    # commit_count
    # end
    # hash = {}
    # Adrlloyd anthonytallent cemccabe beddings81
    # commits.each do |commit|
    #   # binding.pry
    #   if commit[:commit]
    #     if commit[:commit][:author][:name] == "Alastair Lloyd"
    #       # binding.pry 
    #       @alastair += 1
    #     elsif commit[:commit][:author][:name] == "Braxton Eddings"
    #       @braxton += 1
    #     elsif commit[:commit][:author][:name] == "cemccabe" 
    #       @christian += 1
    #     elsif commit[:commit][:author][:name] == "Anthony Blackwell Tallent"
    #       @anthony += 1
    #     end
    #   end
        # hash[commit[:commit][:author][:name]] += 1
        # hash[commit[:author][:login]] +=1
    # end 
    # binding.pry
    # parsed_json[:commit]
    # binding.pry
  # end
  
# end