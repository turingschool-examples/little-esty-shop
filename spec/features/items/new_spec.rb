require 'rails_helper'

RSpec.describe "Merchant Item New Page" do

  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: 'Test', description: 'test', unit_price: 25, merchant_id: @merchant1.id)
  end

  describe "As a merchant" do
    describe "When I visit my items index page" do
      it "I see a link to create a new item" do
        visit "/merchants/#{@merchant1.id}/items"
        # save_and_open_page
        within("#new_item") do
          expect(page).to have_link("Create a New Item")
        end
      end

      describe "When I click the link" do
        it "I am taken to a form that allows me to add item information" do
          visit "/merchants/#{@merchant1.id}/items"

          click_link("Create a New Item")

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

          within("#create_item") do
            expect(page).to have_content("Name:")
            expect(page).to have_field(:name)
            expect(page).to have_content("Description:")
            expect(page).to have_field(:description)
            expect(page).to have_content("Current selling price:")
            expect(page).to have_field(:unit_price)
            expect(page).to have_button("Create Item")
          end
        end
      end

      describe "When I fill out the form I click Submit" do
        it "Then I am taken back to the items index page And I see the item I just created displayed in the list of items. And I see my item was created with a default status of disabled." do

          visit "/merchants/#{@merchant1.id}/items/new"

          fill_in(:name, with: "Boots")
          fill_in(:description, with: "Made for walking")
          fill_in(:unit_price, with: 150)
          click_button("Create Item")

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

          within("#item-#{@merchant1.items.last.id}") do
            expect(page).to have_link("Boots")
            expect(page).to have_content("Status: disabled")
          end
        end
      end
    end
  end
end
