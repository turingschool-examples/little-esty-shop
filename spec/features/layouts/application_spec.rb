require 'rails_helper'

RSpec.describe "Layouts", type: :feature do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)

    pull_requests_count = 3
    allow(GithubFacade).to receive(:pull_requests).and_return(pull_requests_count)
  end

  it 'should have contributer usernames' do
    visit admin_merchants_path
    expect(page).to have_content("Username: gjcarew")
  end

  it 'should have number of commits by user' do
    visit admin_merchants_path
    expect(page).to have_content("Username: gjcarew || Commits: 22")
  end

  it 'should have total number of merged PRs' do
    visit admin_merchants_path
    expect(page).to have_content("Total number of merged Pull Requests: 3")
  end

  it 'should have repo name' do
    visit admin_merchants_path
    expect(page).to have_content("little-esty-shop")
  end
end