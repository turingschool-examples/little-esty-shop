class Repo
  attr_reader :name, :pull_request_count

  def initialize(name)
    @name = name
  end
end