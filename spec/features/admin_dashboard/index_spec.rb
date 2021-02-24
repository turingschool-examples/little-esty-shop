require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  it 'When I visit admin dashboard I see a header
   indicating that I am on the admin dashboard' do

    visit '/admins'

    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")

  end
end
