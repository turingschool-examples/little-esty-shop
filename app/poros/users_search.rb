require './app/services/github_service'
require './app/poros/users'


class UsersSearch
  def service 
    GithubService.new
  end

  def users_information
    array = service.users.map do |data|
      data[:login]
    end
  end

	def usernames_and_commits
		user_commits = service.commits.map do |data|
			User.new(data)
		end
		user_commits.select do |user|
			users_information.include?(user.username)
		end
	end

end
