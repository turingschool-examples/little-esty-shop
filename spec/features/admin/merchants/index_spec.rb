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
  end
end
