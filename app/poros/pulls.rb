class Pulls
  attr_reader :number_of_pulls

  def initialize(json)
    @number_of_pulls = num_pull_requests(json)
  end

  def num_pull_requests(json)
    json.count
  end
end
