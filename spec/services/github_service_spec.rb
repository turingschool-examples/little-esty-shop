# require 'rails_helper'
#
# RSpec.describe GithubService do
#   describe "API repo endpoint" do
#     it 'gets repo data from Github endpoint' do
#       json = GithubService.get_repo_data
#       expect(json).to have_key(:name)
#     end
#   end
#
#   describe "API contributors endpoint" do
#     it 'gets contributor data from Github endpoint' do
#       json = GithubService.get_contributor_data
#       expect(json[0]).to have_key(:login)
#     end
#   end
#
#   describe "API pull request endpoint" do
#     it 'gets pull count from Github endpoint' do
#       json = GithubService.get_pull_data
#       expect(json).to be_an(Array)
#     end
#   end
# end
