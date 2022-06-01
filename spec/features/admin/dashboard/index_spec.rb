require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has an admin header' do
    visit admin_dashboard_path

    within '#header' do
      expect(page).to have_content('Admin Dashboard')
    end
  end

  it 'has links to admin/merchants' do
    visit admin_dashboard_path

    within '#merchants' do
      expect(page).to have_link('Merchants')
      click_link 'Merchants'
      expect(current_path).to eq(admin_merchants_path)
    end
  end

  it 'has links to admin/invoices' do
    visit admin_dashboard_path

    within '#invoices' do
      expect(page).to have_link('Invoices')
      click_link 'Invoices'
      expect(current_path).to eq(admin_invoices_path)
    end
  end
end
