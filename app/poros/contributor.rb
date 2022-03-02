class Contributor
  attr_reader :name, :commits, :id #merged_pr symbol
  def initialize(data)
    @name = data[:login]
    @commits = data[:contributions]
    @id = data[:id]
    # @merged_prs = data[:number]
  end
end
