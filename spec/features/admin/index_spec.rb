require 'rails_helper'

RSpec.describe 'Admin Dashboard Index page' do
  it 'shows admin header' do
    visit admin_index_path

    expect(page).to have_content("Welcome to Admin Dashboard")
  end

#   As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)
  it 'shows links to admin merchants index' do
    visit admin_index_path

    expect(page).to have_link("Admin Merchants Index")
    click_link "Admin Merchants Index"
    expect(current_path).to eq(admin_merchants_path)
  end

  xit 'shows links to admin invoices index' do
    visit admin_index_path

    expect(page).to have_link("Invoices")
    click_link "Invoices"
    expect(current_path).to eq(admin_invoices_path)
  end
end
