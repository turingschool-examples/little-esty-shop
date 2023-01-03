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
    click_link("Merchants Index")
    expect(current_path).to eq("/admin/merchants")
    visit '/admin'
    click_link("Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end




end