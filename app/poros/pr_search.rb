require './app/poros/pr'
require './app/poros/github_service'


class PrSearch
  def self.create_pr 
    user_logins= service.pr_information.map do |data|
      data[:user][:login]
    end
    user_logins.tally
    # require 'pry'; binding.pry

  end

  def self.service 
    GitHubService.new 

  end
end

