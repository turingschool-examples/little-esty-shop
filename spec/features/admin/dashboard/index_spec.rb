require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  it 'shows the header for the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

  it 'shows the links to admin merchants and admin invoices' do
    visit '/admin'
    expect(page).to have_link('Admin Merchants', href: '/admin/merchants')
    expect(page).to have_link('Admin Invoices', href: '/admin/invoices')
  end

  it 'shows the top 5 customers by transaction and the transaction count' do
    visit '/admin'
    data = Customer.top_5_customers_by_transactions
    data.each do |c|
      expect(page).to have_content("#{c.first_name} #{c.last_name} Transactions: #{c.transaction_count}")
    end

  end
end