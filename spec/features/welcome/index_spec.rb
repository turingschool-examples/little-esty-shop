require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'Displays all invoice IDs, each one links to the invoice show page' do
    visit '/'

    expect(page).to have_link('Admin Dashboard', href: admin_dashboard_path)

    fill_in('merchant_id', with: '1')
    click_on('Go to Merchant Dashboard')
    expect(current_path).to eq(merchant_dashboard_path(Merchant.find(1)))
  end
end