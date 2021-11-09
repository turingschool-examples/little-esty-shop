require 'rails_helper'

RSpec.describe 'Admin merchants show page' do
  describe 'page layout' do
    it 'has the merchants name' do
      merchant = Merchant.create(name: 'Test Merchant')

      visit "/admin/merchants/#{merchant.id}"

      expect(page).to have_content(merchant.name)
    end
  end
end
