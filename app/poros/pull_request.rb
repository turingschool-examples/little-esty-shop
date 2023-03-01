class PullRequest
  attr_reader :id,
              :merged_at

  def initialize(data)
    @id = data[:id]
    @merged_at = data[:merged_at]
  end
end