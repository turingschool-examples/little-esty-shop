require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe 'as a merchant' do
    describe 'when I visit my merchant items index page (/merchants/:id/items)' do
      it '- I see a list of the names of all of my items, and I do not see items for any other merchant' do
        crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        surf_designs = Merchant.create!(name: "Surf & Co. Designs")

        dream_catcher = crystal_moon.items.create!(name: "Midnight Dream Catcher", description: "Catch the magic of your dreams!", unit_price: 25)
        rose_quartz = crystal_moon.items.create!(name: "Rose Quartz Pendant", description: "Manifest the love of your life!", unit_price: 37)
        tarot_deck = crystal_moon.items.create!(name: "Witchy Tarot Deck", description: "Unveil your true path!", unit_price: 22)
        wax = surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
        rash_guard = surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
        zinc = surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)

        visit merchant_items_path(crystal_moon)
        # save_and_open_page

        expect(page).to have_content("Welcome To Crystal Moon Designs")
        expect(page).to have_content("Item: Midnight Dream Catcher | Price: $25")
        expect(page).to have_content("Description: Catch the magic of your dreams!")
        expect(page).to have_content("Item: Rose Quartz Pendant | Price: $37")
        expect(page).to have_content("Description: Manifest the love of your life!")
        expect(page).to have_content("Item: Witchy Tarot Deck | Price: $22")
        expect(page).to have_content("Description: Unveil your true path!")
        expect(page).to_not have_content("Welcome To Surf & Co. Designs")
        expect(page).to_not have_content("Item: Board Wax | Price: $7")
        expect(page).to_not have_content("Description: Hang ten!")
      end
    end
  end
end