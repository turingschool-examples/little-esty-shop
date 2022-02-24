require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  it 'exists' do
    visit '/admin'
  end
#   As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
  it 'has an Admin Dashboard header' do
    visit '/admin'
    within 'header'
    expect(page).to have_content("Admin Dashboard")

  end

end
