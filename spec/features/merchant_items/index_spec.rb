require 'rails_helper'

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_2 = @merchant.items.create!(name: "orange",
                                      description: "same name as the color wow!",
                                      unit_price: 2.09)
  end

  describe "when I visit the merchant index page" do
    it "Displays the merchant's name" do

      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content("Harrison")
    end

    it "Displays a list of all the names of this merchant's items" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content("Items")

      within(".items") do
        expect(page).to have_content("apple")
        expect(page).to have_content("orange")
      end
    end
  end

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)
  # And I see all of the item's attributes including:
  #
  # Name
  # Description
  # Current Selling Price

  describe "When I click the name of an item from the merchant items index page" do
    it "takes me to the merchant's item's show page" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_link('apple')
      first(:link, "apple").click
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")

      expect(page).to have_content("apple")

      within(".item_attributes") do
        expect(page).to have_content("one a day keeps the doctor away!")
        expect(page).to have_content("22.09")
      end
    end
  end
end
