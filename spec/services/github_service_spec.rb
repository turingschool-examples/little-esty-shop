# require 'rails_helper'
#
# RSpec.describe GithubService do
#   describe "API repo endpoint" do
#     it 'gets repo data from Github endpoint', :vcr do
#       json = GithubService.get_repo_data
#       expect(json).to have_key(:name)
#     end
#
#     it 'gets pull count from Github endpoint', :vcr do
#       json = GithubService.get_pull_data
#       require "pry"; binding.pry
#       expect(json).to be_an(Array)
#     end
#   end
# end
