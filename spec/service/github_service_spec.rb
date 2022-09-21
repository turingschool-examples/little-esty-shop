require "rails_helper"
require "./app/service/github_service"


RSpec.describe(GitHubService) do
  it("can get all repositories") do
    allow(GitHubService).to(receive(:get_repos).and_return([{name: "little-esty-shop", full_name: "sjmann2/little-esty-shop"}]))
    repos = GitHubService.get_repos
    expect(repos).to(be_an(Array))
    expect(repos[0]).to(be_a(Hash))
    expect(repos[0]).to(have_key(:name))
  end

  it("can get uri") do
    allow(GitHubService).to(receive(:get_uri).and_return([{name: "little-esty-shop", full_name: "sjmann2/little-esty-shop"}]))
    repos = GitHubService.get_uri("https://api.github.com/users/sjmann2/repos")
    expect(repos).to(be_an(Array))
    expect(repos[0]).to(be_a(Hash))
    expect(repos[0]).to(have_key(:name))
  end

  it("can get Pullrequest ") do
    allow(GitHubService).to(receive(:get_uri).and_return([number: 37]))
    repos = GitHubService.get_pr("https://api.github.com/repos/sjmann2/little-esty-shop/pulls?state=all")
    expect(repos).to(be_an(Array))
    expect(repos[0]).to(be_a(Hash))
    expect(repos[0]).to(have_key(:number))
  end

  it 'can get user data' do
    # allow(GitHubService).to receive(:request).and_return([{name: "Noah"}])
    names = GitHubService.request("/collaborators")
    expect(names).to eq [{:login=>"noahvanekdom"}]
  end
end
