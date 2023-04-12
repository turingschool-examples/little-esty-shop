require 'rails_helper'

RSpec.describe 'Admin Index (Dashboard) Page', type: :feature do
  before(:each) do
    visit admin_path
  end

  it 'has a header' do
    expect(page).to have_content('Admin Dashboard')
    expect(page).to have_selector('h1')
  end

  it 'has links to the admin merchants index and admin invoices index' do
    expect(page).to have_link('Admin Merchants Index')
    expect(page).to have_link('Admin Invoices Index')

    click_link('Admin Merchants Index')
    expect(current_path).to eq(admin_merchants_path)

    visit admin_path
    click_link('Admin Invoices Index')
    expect(current_path).to eq(admin_invoices_path)
  end
end
