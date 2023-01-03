require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has a header for the page name' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end

  it 'has links to the admin merch and invoices indices' do
    visit '/admin'
    expect(page).to have_link 'Merchants Index', href: admin_merchants_path
    expect(page).to have_link 'Invoices Index', href: admin_invoices_path
  end




end