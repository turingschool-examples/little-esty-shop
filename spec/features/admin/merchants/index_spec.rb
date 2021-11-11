require 'rails_helper'

RSpec.describe 'admin merchants index' do
  describe 'page layout' do
    it 'has a header' do
      visit "/admin/merchants"

      expect(page).to have_content('Admin Merchants')
    end

    it 'shows the names of merchants' do
      merchant = Merchant.create!(name: 'Test Merchant')

      visit "/admin/merchants"

      expect(page).to have_content(merchant.name)
    end

    it 'has merchant name as link' do
      merchant = Merchant.create!(name: 'Test Merchant')

      visit "/admin/merchants"
      click_on "#{merchant.name}"

      expect(page).to have_current_path("/admin/merchants/#{merchant.id}")
    end

    it 'links to new page' do
      visit "/admin/merchants"

      click_link "New Merchant"

      expect(page).to have_current_path(new_admin_merchant_path)
    end
  end
end
