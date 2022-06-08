require 'rails_helper'

RSpec.describe 'tests for API service methods' do
  xit 'can display the total number of merged pull requests' do
    visit '/admin'
    expect(page).to have_content("Pull Requests: ")
  end

  xit "displays the repo name" do
    visit "admin/merchants"

    expect(page).to have_content("Repo: little-esty-shop")
  end
end