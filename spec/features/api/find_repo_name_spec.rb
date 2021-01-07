require 'rails_helper'

RSpec.describe 'As a user' do
  it "find the repo name" do
    visit "/api/github_api"

    expect(page).to have_content("aidenmendez/little-esty-shop")
  end
end