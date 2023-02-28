class CommitSearch 
  
  def commit_information
    x = service.commits.map do |data| #service is the API call, commit is the method within the API call that tells which API endpiont to fetch 
      Commit.new(data)
    end 
  end
  
  
  def service 
    GithubService.new 
  end
end