require 'rails_helper'

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_2 = @merchant.items.create!(name: "orange",
                                      description: "same name as the color wow!",
                                      unit_price: 2.09,
                                      status: false)
  end
  describe "when I visit the merchant item new page" do
    it "displays a form to create a new item for this merchant with all item attributes" do
      visit "/merchants/#{@merchant.id}/items/new"

      within(".header") do
        expect(page).to have_content("Create a New Item")
      end

      within(".form") do
        expect(page).to have_content("Name")
        expect(page).to have_content("Description")
        expect(page).to have_content("Unit price")
      end
    end

    it "creates a new item and displays name on the merchant items index page" do
      visit "/merchants/#{@merchant.id}/items/new"

      within(".form") do
        fill_in :name, with: "Apple"
        fill_in :description, with: "These are the best fucking apples I've ever tasted"
        fill_in :unit_price, with: 1.50
        click_on 'Add Item'
      end
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end
  end
end
