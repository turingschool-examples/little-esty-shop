require 'rails_helper'

RSpec.describe 'merchant items index page' do
  context 'merchant items user story' do
    it 'lets us see all the item names a merchant has' do
      khajit = Merchant.create!(name: "Khajit")
      bob = Merchant.create!(name: "Bob The Burgerman")

      item_1 = khajit.items.create!(name: "Skooma", description: "Khajit has wares if you have coin", unit_price: 1420 )
      item_2 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )
      item_3 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250 )

      visit "/merchants/#{bob.id}/items"

      within "#item-#{item_2.id}" do
        expect(page).to have_content("Burgers")
        expect(page).to_not have_content("Skooma")
      end

      within "#item-#{item_3.id}" do
        expect(page).to have_content("Fries")
        expect(page).to_not have_content("Skooma")
      end
    end
  end
end