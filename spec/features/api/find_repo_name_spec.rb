require 'rails_helper'

RSpec.describe 'As a user' do
  it "find the repo name" do
    visit "/api/github_api"

    expect(response).to be_successful
  end
end