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

  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed

    it "Displays a button next to each name to disable or enable that item" do
      visit "/merchants/#{@merchant.id}/items"

      within ".buttons" do
        expect(page).to have_button("enable")
      end
    end
  end
end
