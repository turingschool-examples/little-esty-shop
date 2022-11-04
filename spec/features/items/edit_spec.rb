require 'rails_helper'

RSpec.describe 'item edit page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}

  describe 'items#edit' do
    it 'redirects me back to show page where I see a flash message that the update was done successfully' do
      visit edit_merchant_item_path(nomi, lamp)

      fill_in :unit_price, with:  2533

      click_button 'Update Item'

      expect(current_path).to eq(merchant_item_path(nomi, lamp))

      expect(page).to have_content("$25.33")

      expect(page).to have_content("Successfully Updated #{lamp.name}")
    end
  end
end
