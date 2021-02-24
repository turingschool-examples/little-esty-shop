require 'rails_helper'
RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_1 = @merchant.items.create!(name: "orange",
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
end
