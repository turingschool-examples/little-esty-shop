class User
  attr_reader :contributors

  def initialize(contributor_data)
    @contributors = contributor_data.map do |contributor|
                      contributor[:login]
                    end
  end
end