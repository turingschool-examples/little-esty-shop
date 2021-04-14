require 'rails_helper'

RSpec.describe 'when I visit the admin dashboard' do
  it 'displays header indicating that I am on the dashboard' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows a link to the admin merchants index' do
    visit '/admin'
    expect(page).to have_link('Admin Merchants Index', href: admin_merchants_path)
  end

  it 'shows a link to the admin invoices index' do
    visit '/admin'
    expect(page).to have_link('Admin Invoices Index', href: admin_invoices_path)
  end
end
