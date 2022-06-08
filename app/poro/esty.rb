class Repo
  attr_reader :name

  def initialize(parsed_repo)
    @name = parsed_repo[:name]
  end

end
# create a avatar class dont use this one
