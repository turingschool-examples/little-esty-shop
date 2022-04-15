require 'rails_helper'


RSpec.describe 'Admin Merchant Index' do
  describe 'Admin Merchant Index Page' do
    it 'lists each merchant in the system' do
      merchant_1 = Merchant.create!(name: 'Brylan')
      merchant_2 = Merchant.create!(name: 'Antonio')
      merchant_3 = Merchant.create!(name: 'Chris')
      merchant_4 = Merchant.create!(name: 'Craig')

      visit "/admin/merchants"

      expect(page).to have_content('Brylan')
      expect(page).to have_content('Antonio')
      expect(page).to have_content('Chris')
      expect(page).to have_content('Craig')

    end

    it 'has link to each merchant show page by clicking name' do
      merchant_1 = Merchant.create!(name: 'Brylan')
      visit "/admin/merchants"

      click_link "Brylan"
      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    end
  end
end
