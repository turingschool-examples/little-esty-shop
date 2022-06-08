class PullRequest
  attr_reader :merged_at

  def initialize(data)
    require 'pry'
    binding.pry
    @merged_at = data[:merged_at]
  end
end
