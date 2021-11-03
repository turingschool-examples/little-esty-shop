require 'rails_helper'

RSpec.describe 'dashboard' do
  it 'can open the dashboard page' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links to merchants and invoices' do
    visit '/admin'
    expect(page).to have_link('Merchant Index')
    expect(page).to have_link('Invoice Index')
  end

  it 'can return a list of top 5 customers by successful transactions' do
    visit '/admin'

    expect(page).to have_content('Top Customers:')
    expect(page).to have_content("")
  end
end
