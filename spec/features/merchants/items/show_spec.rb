require 'rails_helper'

RSpec.describe 'merchant items index page' do
  describe 'as a merchant' do
    describe 'when i visit my merchant items index page' do
      it 'i see a list of the names of all of my items and i do not see items for any other merchant' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)

        visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.description)
        expect(page).to have_content("Current Selling Price: $250000.00")
        expect(page).not_to have_content(item_2.name)
        expect(page).not_to have_content(item_2.description)
        expect(page).not_to have_content(item_2.unit_price)
      end
    end
  end
end
