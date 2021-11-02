require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  describe 'Merchant Dashboard' do
    it 'shows merchant name' do
      merchant = Merchant.create!(name: 'Willms and Sons')
      visit "/merchants/#{merchant.id}/dashboard"
      save_and_open_page
      expect(page).to have_content(merchant.name)
    end
  end
end