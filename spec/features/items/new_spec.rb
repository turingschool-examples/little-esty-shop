require 'rails_helper'

RSpec.describe 'creating a new item', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}

  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}

  describe 'items#new' do
    it 'creates a new item then displays in the list of items with a default status of disabled' do
      visit new_merchant_item_path(nomi)

      fill_in :name, with: 'Blue Mesh Shorts'
      fill_in :description, with: 'Brand new heavy mesh - premium version! Comes with an inner waist drawstring and deep side hem pockets.'
      fill_in :unit_price, with: 2559

      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(nomi))

      new_item = Item.last
      within ("#disabled") do
        expect(page).to have_content(new_item.name)
      end
    end

    it 'returns an error message if fields are not filled correctly' do
      visit new_merchant_item_path(nomi)

      fill_in :name, with: 'Blue Mesh Shorts'
      fill_in :description, with: ' '
      fill_in :unit_price, with: 2559

      click_button 'Create Item'

      expect(current_path).to eq(new_merchant_item_path(nomi))

      expect(page).to have_content("Description can't be blank")
    end
  end
end