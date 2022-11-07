require 'rails_helper'

RSpec.describe 'Admin index page' do
  it 'displays a header indicating the page is the admin dashboard' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end
  it 'contains links to admin merchants index and admin invoices index' do
    visit '/admin'
    expect(page).to have_link("Merchants")
    expect(page).to have_link("Invoices")

    click_link "Merchants"
    expect(page).to have_current_path(admin_merchants_path)

    visit '/admin'

    # click_link "Invoices"
    # expect(page).to have_current_path(admin_invoices_path)
  end
end
