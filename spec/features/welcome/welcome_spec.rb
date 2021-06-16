require 'rails_helper'
RSpec.describe 'welcome page' do
  it 'has links to main pages on the site' do
    visit "/"

    expect(page).to have_link("Admin: Merchants", href: "/admin/merchants")
    expect(page).to have_link("Admin: Invoices", href: "/admin/invoices")
    expect(page).to have_link("Admin Dashboard")
    expect(page).to have_link("Example Merchant: Invoices", href: "/merchants/1/invoices")
    expect(page).to have_link("Example Merchant: Items", href: "/merchants/1/items")
    expect(page).to have_link("Example Merchant Dashboard", href: "/merchants/1/dashboard")
    expect(page).to have_link("Example Merchant: Bulk Discounts", href: "/merchants/1/bulk_discounts")
  end
end
