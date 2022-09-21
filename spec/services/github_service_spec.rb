require 'rails_helper'

RSpec.describe GithubService do
  it 'can get all repos' do
    allow(GithubService).to receive(:get_repos).and_return([{name: "Crimson Sky"}])
    repos = GithubService.get_repos
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_an(Hash)
    expect(repos[0]).to have_key(:name)
  end
end
