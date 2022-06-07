class Repo
  attr_reader :name

  def initialize(parsed_repo)
    @name = parsed_repo[:name]
  end
  
end
