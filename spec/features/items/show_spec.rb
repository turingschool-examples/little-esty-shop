require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  
  describe 'item#show' do
    it 'shows the items name, description, and current selling price' do
      visit merchant_item_path(nomi, lamp)
      save_and_open_page
      expect(page).to have_content(lamp.name)

      within ("#information") do
        expect(page).to have_content("Description: #{lamp.description}")
        expect(page).to have_content("Current Price: $#{lamp.current_price}")
      end
    end
  end
end