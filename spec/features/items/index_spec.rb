require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe 'as a merchant' do
    describe 'when I visit my merchant items index page (/merchants/:id/items)' do
      before :each do
        @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        @surf_designs = Merchant.create!(name: "Surf & Co. Designs")

        @dream_catcher = @crystal_moon.items.create!(name: "Midnight Dream Catcher", description: "Catch the magic of your dreams!", unit_price: 25)
        @rose_quartz = @crystal_moon.items.create!(name: "Rose Quartz Pendant", description: "Manifest the love of your life!", unit_price: 37)
        @tarot_deck = @crystal_moon.items.create!(name: "Witchy Tarot Deck", description: "Unveil your true path!", unit_price: 22)
        @wax = @surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
        @rash_guard = @surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
        @zinc = @surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)
      end

      it '- I see a list of the names of all of my items, and I do not see items for any other merchant' do
       
        visit merchant_items_path(@crystal_moon)

        expect(page).to have_content("Welcome To Crystal Moon Designs")
        expect(page).to have_content("Midnight Dream Catcher")
        expect(page).to have_content("Rose Quartz Pendant")
        expect(page).to have_content("Witchy Tarot Deck")
        expect(page).to_not have_content("Welcome To Surf & Co. Designs")
        expect(page).to_not have_content("Board Wax")
      end

      it 'should have each item name as a link that redirects to the show page of that item' do
        visit merchant_items_path(@crystal_moon)

        expect(page).to have_link("Midnight Dream Catcher")

        click_link "Midnight Dream Catcher"

        expect(page).to have_current_path(merchant_item_path(@crystal_moon, @dream_catcher))
        expect(page).to have_content("Item: Midnight Dream Catcher")
      end

      it '- next to each item name I see a button to disable or enable that item.
      when I click this button, I am redirected back to the items index and I see 
      that the items status has changed' do
        visit merchant_items_path(@surf_designs)

        expect(page).to have_button("Disable Board Wax")
        expect(page).to have_content("available for purchase")

        click_button "Disable Board Wax"
        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items")
        
        expect(page).to have_content("Status: not available for purchase")
        expect(page).to have_button("Enable Board Wax")
        
        click_button "Enable Board Wax"
        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items")

        expect(page).to have_content("Status: available for purchase")
      end

      it '- I see two sections, one for enabled items, and one for disabled items.
      I see that each item it listed in the appropriate section' do
        visit merchant_items_path(@crystal_moon)

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to have_content("Witchy Tarot Deck")
        end

        within "#disabled" do
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Disable Rose Quartz Pendant"

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Disable Midnight Dream Catcher"

        within "#enabled" do
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Enable Midnight Dream Catcher"

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end
      end

      it '- I see a link to create a new item' do
        visit merchant_items_path(@surf_designs)

        expect(page).to have_link("Create New Item", href: "/merchants/#{@surf_designs.id}/items/new")
      end

      xit '- When I click the link, I am taken to a form that 
      allows me to add item information. when I fill out the form
      I click (submit). then I am taken back to the items index page.' do

      end

      xit '- I see the item I just created displayed in the list of items, and
      I see that my item was created with a default status of disabled.' do

      end
    end
  end
end