require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an admin user' do
    it "when I visit the admin dashboard I see a header" do 

      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  
    it 'I see a link to the admin merchants and invoices index' do
      visit admin_path

      expect(page).to have_link('Merchants')
      expect(page).to have_link('Invoices')
      
      click_link 'Merchants'

      expect(current_path).to eq(admin_merchants_path)

      visit admin_path

      click_link 'Invoices'

      expect(current_path).to eq(admin_invoices_path)
    end
  end 
end 
