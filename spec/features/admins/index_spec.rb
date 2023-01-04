require 'rails_helper'

RSpec.describe 'admins dashboard' do
  it 'shows header indicating that I am on the admin dashboard' do
    visit admin_index_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it 'contains links to the admin merchants index' do
    visit admin_index_path

    expect(page).to have_link('Merchants')

    click_link 'Merchants'

    # expect(current_path).to eq(merchants_index_path)
  end

  it 'contains links to the admin invoices index' do
    visit admin_index_path
    
    expect(page).to have_link('Invoices')

    click_link 'Invoices'

    # expect(current_path).to eq(invoices_index_path)
  end
end