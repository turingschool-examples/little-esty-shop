require 'json'
require './app/poros/repo_search'

repos = RepoSearch.new.repo_information

repos.each do |repo|
  puts repo.name
end