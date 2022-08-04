class Repo
  attr_reader :name,
              :language,
              :forks_count,
              :visibility,
              :open_issues_count,
              :created_at,
              :updated_at,
              :pushed_at

  def initialize(data)
    @name = data[:name]
    @language = data[:language]
    @forks_count = data[:forks_count]
    @visibility = data[:visibility]
    @open_issues_count = data[:open_issues_count]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @pushed_at = data[:pushed_at]
  end
end
