require 'rails_helper'

RSpec.desribe 'the merchants items index' do
  describe 'as a merchant'

    xit 'each item on my items index is a link to the show page' do
      merchant = Merchant.create(name: 'Toys and Stuff')
      item = merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )

      visit "/merchants/#{merchant.id}/items"
      click_on item.name

      expect(current_path).to eq "/merchants/#{merchant.id}/items/#{item.id}"
    end
  end
end
