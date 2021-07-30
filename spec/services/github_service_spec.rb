require 'rails_helper'

RSpec.describe GithubService do
  before :each do
    @service = GithubService.new

    @response = @service.get_repo
  end

  it 'can return repo' do
    expect(@response).to be_an(Array)
  end

  it 'test' do
    expected =  ["BrianZanti", "matttoensing", "Bhjones45", "JasonPKnoll", "deebot10", "timomitchel", "scottalexandra", "jamisonordway"]

    expect(@service.contributors).to eq(expected)
  end

  it 'test2' do
    expect(@service.contributors_commits).to eq([51, 37, 33, 23, 20, 9, 3, 1])
  end

  it 'test3' do

    expected = {"Bhjones45" => 33,
    "BrianZanti" => 51,
    "JasonPKnoll" => 23,
    "deebot10" => 20,
    "jamisonordway" => 1,
    "matttoensing" => 37,
    "scottalexandra" => 3,
    "timomitchel" => 9}

    expect(@service.commits).to eq(expected)
  end
end
