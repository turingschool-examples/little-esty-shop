require 'rails_helper'

RSpec.describe 'admin merchant index page' do
  describe '#index' do
    it 'displays the names of all the merchants' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Jon Doe Dough')
      merchant_3 = Merchant.create!(name: 'Mary Shelley Books')

      visit '/admin/merchants'

      expect(page).to have_content('Spongebob The Merchant')
      expect(page).to have_content('Jon Doe Dough')
      expect(page).to have_content('Mary Shelley Books')
    end
  end
end