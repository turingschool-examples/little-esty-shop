require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: 'Test', description: 'test', unit_price: 25, merchant_id: @merchant1.id)
  end

  describe "As a merchant" do
    describe "When I visit my merchant items index page" do
      it "I see a list of names of all of my items and do not see items for any other merchant" do

      visit "/merchants/#{@merchant1.id}/items"
      # save_and_open_page

      expect(page).to have_content("#{@merchant1.name} Inventory")

      expect(page).to have_content("Items:")
      expect(page).to_not have_content("Bat-A-Rangs")

      within("#item-#{@item1.id}") do
        expect(page).to have_content(@item1.name)
      end

      within("#item-#{@item3.id}") do
        expect(page).to have_content(@item3.name)
      end
      end
    end
  end
end
