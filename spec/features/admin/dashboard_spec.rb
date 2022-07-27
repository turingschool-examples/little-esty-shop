require 'rails_helper'

RSpec.describe 'Admin Dashboard page' do
  it 'has a header showing Admin Dashboard' do
    visit admin_path

    within('#admin-header') do
      expect(page).to have_content("Admin Dashboard")
    end
  end
  it 'has a link to /admin/merchants' do
    visit admin_path

    within('#admin-links') do
      expect(page).to have_link('Merchants')
    end
  end
  it 'has a link to /admin/invoicess' do
    visit admin_path

    within('#admin-links') do
      expect(page).to have_link('Invoices')
    end
  end
end