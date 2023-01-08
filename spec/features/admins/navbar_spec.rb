require 'rails_helper'

RSpec.describe 'admin navbar' do
  it 'shows the little esty shop header' do
    visit admin_merchants_path
    
    expect(page).to have_content("Little Esty Shop")
  end

  it 'shows the little esty shop header' do
    visit admin_invoices_path
    
    expect(page).to have_content("Little Esty Shop")
  end

  it 'shows header indicating that I am on the admin dashboard' do
    visit admin_invoices_path

      within("#admin_navbar") do
        expect(page).to have_content("Admin Dashboard")
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Invoices')
      end
  end

  it 'shows header indicating that I am on the admin dashboard' do
    visit admin_merchants_path

      within("#admin_navbar") do
        expect(page).to have_content("Admin Dashboard")
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Invoices')
      end
  end
end