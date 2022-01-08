require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
  describe 'view' do

    it 'I see the name of each invoice in the system' do
      visit "/admin/invoices"

      expect(page).to have_content("Invoices")
      expect(page).to have_content(@invoice_1.id)
    end

    it 'Each id links to the admin invoice show page' do
      visit "/admin/invoices"
      
      click_link "#{@invoice_1.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
  end
end
