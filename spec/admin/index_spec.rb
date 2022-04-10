require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it 'displays a header indicating that user is on the admin dashboard' do
    visit '/admin'
    within(".header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
end
