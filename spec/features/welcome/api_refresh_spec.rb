require 'rails_helper'

RSpec.describe 'Github API Statistics' do
  before :each do
    visit '/'
    @repo_name = API.repo_name
    @user_names = API.user_names
    @contributions = API.contributions[:defaults][:commits]
  end
  # As a visitor or an admin user
    # When I visit any page on the site
    # I see the number of commits next to each Github username
    # This number is updated as each member of the team contributes more commits
    # I see the number of merged PRs across all team members
    # This number is updated as each member of the team merges more PRs
  it 'displays the navbar dropdown for API statistics' do
    expect(current_path).to eq('/')
    expect(page).to have_content('Github Stats')

    click_on('Github Stats')
    within "#dropdownmenu-github" do
      expect(page).to have_content(@repo_name)
      expect(page).to have_content("Total Commits:")
      expect(page).to have_content("Pull Requests:")
      @user_names.values.each do |user_name|
        expect(page).to have_content(user_name)
        expect(page).to have_content(@contributions[user_name])
      end
    end
  end

  it 'can refresh API statistics with a redirect back to the current page' do
    click_on('Github Stats')
    click_on('Refresh Stats 🔄')

    expect(current_path).to eq('/')
  end

end
