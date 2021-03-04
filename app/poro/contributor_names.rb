class ContributorNames
  attr_reader :names

  def initialize(data)
    @names = []
    data.each do |json|
      @names << json[:login]
    end
  end
end
