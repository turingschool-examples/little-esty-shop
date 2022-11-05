require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: 'Test', description: 'test', unit_price: 25, merchant_id: @merchant1.id)
  end

  describe "As a merchant," do
    describe "When I click on the name of an item from the merchant items index page," do
      it "# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)" do
        visit "/merchants/#{@merchant1.id}/items"

        within("#item-#{@item1.id}") do
          expect(page).to have_link("#{@item1.name}")
        end

        within("#item-#{@item3.id}") do
          expect(page).to have_link("#{@item3.name}")
        end

        click_link("#{@item1.name}")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      end

      it "And I see all of the item's attributes including: Name, Description, Current Selling Price" do

        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
        # save_and_open_page
        expect(page).to have_content("Name: #{@item1.name}")
        expect(page).to have_content("Description: #{@item1.description}")
        expect(page).to have_content("Current Selling Price: $#{@item1.unit_price}")
      end
    end
  end
end
