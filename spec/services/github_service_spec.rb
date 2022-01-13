# require 'rails_helper'
# require "httparty"
# RSpec.describe GithubService do
#   VCR.turn_on!
#
#   it 'returns the repo', :vcr, js: true do
#     github_service = GithubService.new
#     VCR.use_cassette("returns_the_repo") do
#     expect(github_service.repo_name).to eq("little-esty-shop")
#     end
#   end
#
#   it 'returns the contributors', :vcr, js: true do
#     github_service = GithubService.new
#     VCR.use_cassette("returns_the_contributors") do
#     expect(github_service.get_contributor).to eq(["BrianZanti", "dylan-harper", "Henchworm", "croixk", "jacksonvaldez", "timomitchel", "scottalexandra", "jamisonordway"])
#     end
#   end
#
#   it 'gets commits per person', :vcr, js: true do
#     github_service = GithubService.new
#     VCR.use_cassette("gets_commits_per_person") do
#     expect(github_service.get_commits_per_person).to eq({"BrianZanti"=>51, "Henchworm"=>42, "croixk"=>22, "dylan-harper"=>49, "jacksonvaldez"=>10, "jamisonordway"=>1, "scottalexandra"=>3, "timomitchel"=>9})
#     end
#   end
#
#   it 'gets all merged commits', :vcr, js: true do
#     github_service = GithubService.new
#     VCR.use_cassette("gets_all_merged_commits") do
#     expect(github_service.get_all_merged).to be_a(Integer)
#     expect(80).to be <= (github_service.get_all_merged)
#     end
#   end
# end
#
