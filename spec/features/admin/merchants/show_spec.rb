require 'rails_helper'

RSpec.describe 'Admin merchants show page' do
  describe 'page layout' do
    it 'has the merchants name' do
      merchant = Merchant.create(name: 'Test Merchant')

      visit admin_merchant_path(merchant)

      expect(page).to have_content(merchant.name)
    end

    it 'links to update page' do
      merchant = Merchant.create(name: 'Test Merchant')

      visit admin_merchant_path(merchant)

      click_link "Update #{merchant.name}"

      expect(page).to have_current_path(edit_admin_merchant_path(merchant))
    end
  end
end
