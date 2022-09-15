require 'rails_helper'

RSpec.describe 'As an admin,' do
  describe 'When I visit the admin Invoices index ("/admin/invoices")' do
    it 'Then I see a list of all Invoice ids in the system' do
      visit admin_invoices_path

      expect(page).to have_content("Invoice #1")
      expect(page).to have_content("Invoice #2")
      expect(page).to have_content("Invoice #3")
      expect(page).to have_content("Invoice #4")
    end

    it 'Each id links to the admin invoice show page' do
      visit admin_invoices_path

      expect(page).to have_link("Invoice #1")
      expect(page).to have_link("Invoice #2")
      expect(page).to have_link("Invoice #3")
      expect(page).to have_link("Invoice #4")
    end
  end
end
