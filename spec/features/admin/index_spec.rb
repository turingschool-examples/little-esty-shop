require 'rails_helper'
# Admin Dashboard

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
RSpec.describe 'Admin' do
  it 'it shows admin dashboard' do
    visit '/admin' 

    expect(page).to have_content('Admin Dashboard')
  end
end