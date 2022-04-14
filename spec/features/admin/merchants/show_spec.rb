require 'rails_helper'


RSpec.describe 'Admin Merchant Show' do
  describe 'Admin Merchant Show Page' do
    it 'displays merchant name of show page' do
      merchant_1 = Merchant.create!(name: 'Brylan')

      visit "/admin/merchants/#{merchant_1.id}"
      expect(page).to have_content("Brylan")
    end
  end
end
