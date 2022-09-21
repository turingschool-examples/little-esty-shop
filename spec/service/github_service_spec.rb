require 'rails_helper'
require './app/service/github_service'

RSpec.describe GitHubService do
  it 'can get all repositories' do
    allow(GitHubService).to receive(:get_repos).and_return([{name: 'little-esty-shop',
                                                            full_name: 'sjmann2/little-esty-shop'}])
    repos = GitHubService.get_repos
    
    expect(repos).to be_an(Array)
    expect(repos[0]).to be_a(Hash)
    expect(repos[0]).to have_key(:name)
  end

  it 'can get uri' do
    allow(GitHubService).to receive(:get_uri).and_return([{name: 'little-esty-shop',
      full_name: 'sjmann2/little-esty-shop'}])
  end
end
