require 'rails_helper'

RSpec.describe 'As a user' do
  it "find the repo name" do
    visit "/services/v1/repo_name"

    expect(response).to be_successful
  end
end