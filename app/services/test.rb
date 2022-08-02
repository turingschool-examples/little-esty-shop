require './app/services/repo_search'
require 'pry'

search = RepoSearch.new
# binding.pry

puts search.repo_information.name
puts search.repo_information.language
puts search.repo_information.forks_count
puts search.repo_information.visibility
puts search.repo_information.open_issues_count
puts search.repo_information.created_at
puts search.repo_information.updated_at
puts search.repo_information.pushed_at
