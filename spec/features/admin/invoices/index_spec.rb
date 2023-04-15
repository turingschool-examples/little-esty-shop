require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before(:each) do
    test_data
  end

  describe 'User Story 32' do
    it 'displays all invoice ids' do
      visit '/admin/invoices'
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it 'links to the admin invoice show page' do
      visit '/admin/invoices'
      within "#invoice-#{@invoice_1.id}" do
        click_link @invoice_1.id
      end
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      visit '/admin/invoices'
      save_and_open_page
      within "#invoice-#{@invoice_2.id}" do
        click_link @invoice_2.id
      end
      expect(current_path).to eq(admin_invoice_path(@invoice_2))
    end
  end
end