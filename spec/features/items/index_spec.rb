require 'rails_helper'

RSpec.describe 'items index page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  
  describe 'items#index' do
    it 'shows a list of names of all merchants items' do
      visit merchant_items_path(nomi)

      expect(page).to have_content(nomi.name)

      within ("#my-items") do
        expect(page).to have_content(stickers.name)
        expect(page).to have_content(lamp.name)
        expect(page).to have_content(orion.name)

        expect(page).to_not have_content(oil.name)
      end
    end

    it 'takes you to item show page when you click on the link on the item name' do
      visit merchant_items_path(nomi)

      within ("#my-items") do
        click_link lamp.name
      end

      expect(current_path).to eq(merchant_item_path(nomi, lamp))
    end

    it 'has disable/enable buttons near each item' do
      visit merchant_items_path(nomi)

      expect(lamp.status).to eq(:disabled)


    end
  end
end