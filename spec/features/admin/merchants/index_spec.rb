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
  end
end
