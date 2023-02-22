require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As a user when I visit the admin dashboard' do
    it 'I see a header indicating the admin dashboard' do 
      visit "/admin"

      expect(page).to have_content "Admin DashBoard"
    end

    it 'I see links to the admin merchants index page' do
      visit "/admin"

      click_link "Admin Merchants Index"
      expect(current_path).to eq "/admin/merchants"
    end

    it 'I see links to the admin invoices index page' do
      visit "/admin"
      click_link "Admin Invoices Index"
      expect(current_path).to eq "/admin/invoices"

    end
  end
end