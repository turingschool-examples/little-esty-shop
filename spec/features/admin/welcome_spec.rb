require 'rails_helper'

RSpec.describe 'when I visit the admin dashboard' do
  it 'displays header indicating that I am on the dashboard' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end
end








# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard