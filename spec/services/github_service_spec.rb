require 'rails_helper'

RSpec.describe GithubService do
  it 'can get all repos' do
    allow(GithubService).to receive(:get_repos).and_return([{name: "Crimson Sky"}])
    repos = GithubService.get_repos
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_an(Hash)
    expect(repos[0]).to have_key(:name)
  end

  it 'can get total merged pull requests made for repo' do
    allow(GithubService).to receive(:get_total_pulls).and_return([{total_count: 2 }])
    repos = GithubService.get_total_pulls
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_an(Hash)
    expect(repos[0]).to have_key(:total_count)
  end

  it 'contributors' do
    allow(GithubService).to receive(:get_contributors).and_return([{login: "BrianZanti"}])
    repos = GithubService.get_contributors
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_an(Hash)
    expect(repos[0]).to have_key(:login)
  end

  it 'number of commits' do
    allow(GithubService).to receive(:get_contributors).and_return([{contributions: 96}])
    repos = GithubService.get_contributors
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_an(Hash)
    expect(repos[0]).to have_key(:contributions)
  end
end
