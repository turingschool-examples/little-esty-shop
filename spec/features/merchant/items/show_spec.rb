require 'rails_helper'

RSpec.describe "Merchant Item's Show Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_2 = @merchant.items.create!(name: "orange",
                                      description: "same name as the color wow!",
                                      unit_price: 2.09)
  end

  describe "When I click the name of an item from the merchant items index page" do
    it "takes me to the merchant's item's show page" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_link('apple')
      first(:link, "apple").click
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")

      expect(page).to have_content("apple")

      within(".item_attributes") do
        expect(page).to have_content("one a day keeps the doctor away!")
        expect(page).to have_content("Price: $22.09")
      end
    end
  end

  describe "When I click the name of an item from the merchant items index page I see a link to update an item" do
    it "takes me a a page to edit this item" do
      visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"

      within(".update-link") do
        expect(page).to have_link('Update Item')
        click_link('Update Item')
      end
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}/edit")
    end
  end
end
