require 'rails_helper'

RSpec.describe GithubRepo do
  it 'exisits' do
    repo = GithubRepo.new(name: 'little-esty-shop')

    expect(repo).to be_a GithubRepo
  end

  it 'stores the name of the repo' do
    repo = GithubRepo.new(name: 'little-esty-shop')

    expect(repo.name).to eq 'little-esty-shop'
  end
end
