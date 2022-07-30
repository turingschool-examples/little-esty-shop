require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  describe '#show' do
    it 'displays the name of all the merchant' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Jon Doe Dough')

      visit "/admin/merchants/#{merchant_1.id}"

      expect(page).to have_content('Spongebob The Merchant')
      expect(page).to_not have_content('Jon Doe Dough')   
    end
  end
end