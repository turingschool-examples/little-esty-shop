require './lib/git_repo'

puts GitRepo.new.usernames

puts GitRepo.new.repo_name

puts GitRepo.new.commits_by_contributors

puts GitRepo.new.number_of_pull_requests