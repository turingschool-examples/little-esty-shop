require 'rails_helper'

RSpec.describe 'items index page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  
  describe 'items#index' do
    it 'shows a list of names of all merchants items' do
      visit "/merchants/#{nomi.id}/items"

      expect(page).to have_content(nomi.name)

      within ("#my-items") do
        expect(page).to have_content(stickers.name)
        expect(page).to have_content(lamp.name)
        expect(page).to have_content(orion.name)

        expect(page).to_not have_content(oil.name)
      end
    end
  end
end