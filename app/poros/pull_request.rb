class PullRequest
def initialize(data_hash)
  @contributor = data_hash[:user][:login]
end
end
