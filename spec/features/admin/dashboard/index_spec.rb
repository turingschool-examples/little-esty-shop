require 'rails_helper'

RSpec.describe 'admin dashboard' do
  describe 'page layout' do
    it 'has a header' do
      visit "/admin/dashboard"

      expect(page).to have_content('Admin Dashboard')
    end

    it 'has a link to admin merchants index' do
      visit "/admin/dashboard"

      click_on "Admin Merchants Index"

      expect(page).to have_current_path("/admin/merchants")
    end

    it 'has a link to admin invoices index' do
      visit "/admin/dashboard"

      click_on "Admin Invoices Index"

      expect(page).to have_current_path("/admin/invoices")
    end
  end
end
