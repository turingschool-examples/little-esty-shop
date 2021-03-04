class User
  attr_reader :contributors

  def initialize(contributor_data)
    @contributors = get_contributors(contributor_data)
  end

  def get_contributors(data)
    contributors = {}
    data.each do |contributor|
      contributors[contributor[:login]] = contributor[:contributions]
    end
    contributors
  end
end
