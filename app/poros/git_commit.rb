require 'pry'
require './app/poros/commit_search'

search = CommitSearch.new

search.commit_information.each do |commit|
  puts commit.name
  puts commit.contributions
end
