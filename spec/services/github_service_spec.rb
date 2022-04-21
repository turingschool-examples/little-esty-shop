require "rails_helper"

RSpec.describe GithubService do
  describe "API repo endpoint" do
    it "gets repo data from github endpoint", :vcr do
      json = GithubService.get_repo_data
      expect(json).to have_key(:name)
    end
  end

  describe "API contributors endpoint" do
    it "gets contributors data from github endpoint", :vcr do
      json = GithubService.get_contributors_data
      expect(json).to have_key(:login)
    end
  end
end
