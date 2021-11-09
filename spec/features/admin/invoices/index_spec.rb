require 'rails_helper'

RSpec.describe 'admin invoices index' do
  describe 'page layout' do
    it 'has a header' do
      visit "/admin/invoices"

      expect(page).to have_content('Admin Invoices')
    end

    it 'shows the names of merchants' do
      invoice = Invoice.create!(name: 'Test Merchant')

      visit "/admin/invoices"

      expect(page).to have_content(invoice.id)
    end
  end
end
