require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    visit '/admin'
  end

  it "has a header letting you know it's the admin dash" do

    expect(page).to have_content("Admin Dashboard")
  end
end
