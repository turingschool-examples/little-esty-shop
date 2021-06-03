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

  it 'shows incomplete invoices by created' do
    visit '/admin'
    within '#incomplete_invoices' do
      expect(page).to have_content('Incomplete Invoices')
      expect(page).to have_selector('.incomp', count: 288)
      expect(page).to have_content('158 Tuesday, March 06, 2012')
      expect(page).to have_content('282 Tuesday, March 06, 2012')
      expect(page).to have_content('240 Tuesday, March 06, 2012')
      first = page.find('#invoice-158')
      second = page.find('#invoice-282')
      third = page.find('#invoice-240')
      expect(first).to appear_before(second)
      expect(second).to appear_before(third)
    end
  end
end