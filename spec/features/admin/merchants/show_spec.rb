require 'rails_helper'


RSpec.describe 'Admin Merchant Index' do
  describe 'Admin Merchant Index Page' do
    it 'lists each merchant in the system' do
      merchant_1 = Merchant.create!(name: 'Brylan')

      visit "/admin/merchants/#{merchant_1.id}"
      expect(page).to have_content("Brylan")


    end
  end
end
