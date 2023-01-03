require 'rails_helper'

RSpec.describe 'admin index page' do
  describe 'header' do
    it 'indicates we are on admin dashboard with header' do
      visit admin_index_path

      within('header') do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'has links to admin merchants and admin invoices' do
      visit admin_index_path

      within('header') do
        expect(page).to have_link("Merchants", href: admin_merchants_path)
        expect(page).to have_link("Invoices", href: admin_invoices_path)
      end
    end
  end
end
