require 'rails_helper'

RSpec.describe "Admin Dashboard", type: :feature do
  describe "Admin User Story 1 - Admin Dashboard" do
    it "can display a header" do
      visit '/admin'

      within '#leftSide' do
      expect(page).to have_content("Admin Dashboard")

      end
    end
  end

  describe "Admin User Story 2 - Admin Dashboard Links" do
    it "has a admin merchants index link and admin invoices index link" do
      visit '/admin'

      click_link 'Merchants'
      visit '/admin/merchants'

      expect(current_path).to eq('/admin/merchants')

      visit '/admin'

      click_link 'Invoices'
      visit '/admin/invoices'

      expect(current_path).to eq('/admin/invoices')


    end
  end
end
