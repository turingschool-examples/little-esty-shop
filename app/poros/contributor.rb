class Contributor
  attr_reader :login,
              :contributions
  
  def initialize(repo_data)
    require "pry"; binding.pry
    @login = repo_data[:login]
    @contributions = repo_data[:contributions]
  end
end