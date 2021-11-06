require 'rails_helper'

RSpec.describe 'the merchant items show page' do
  describe 'as a merchant' do
    it 'the show page shows me all of the items attributes' do
      merchant = Merchant.create(name: 'Toys and Stuff')
      item = merchant.items.create(name: 'fidget spinner', description: 'it spins', unit_price: 1500)

      visit "/merchants/#{merchant.id}/items/#{item.id}"

      expect(page).to have_content item.name
      expect(page).to have_content item.description
      expect(page).to have_content 'Price: $15.00'
    end
  end
end
