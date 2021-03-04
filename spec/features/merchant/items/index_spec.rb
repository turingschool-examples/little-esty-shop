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
                                      status: 1)
  end

  describe "when I visit the merchant index page" do
    it "Displays the merchant's name" do
      visit "/merchants/#{@merchant.id}/items"
      expect(page).to have_content("Harrison")
    end

    it "Displays a list of all the names of this merchant's items" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content("Items")
      expect(page).to have_content("apple")
      expect(page).to have_content("orange")
    end

    it "displays all listed items as links to thier item show page" do
      visit "/merchants/#{@merchant.id}/items"

      within("#disabled-items") do
        expect(page).to have_link(@item_2.name)
        first(:link, "#{@item_2.name}").click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_2.id}")
      end
    end

    it "Displays a button next to each name to disable or enable that item" do
      visit "/merchants/#{@merchant.id}/items"

      within "#enabled-items" do
        expect(page).to have_link(@item_1.name)
        expect(page).to have_button("disable")
        first(:button, "disable").click

        expect(page).not_to have_link(@item_1.name)
      end
    end

    it "Displays a new item link that takes you to a form to create a new item" do
      visit "/merchants/#{@merchant.id}/items"

      within "#new-item" do
        expect(page).to have_link("New Item")
        click_on("New Item")

        expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
      end
    end

    it "Displays a section that has the top 5 items by revenue" do

      @merchant.stub(:top_5_items_by_revenue).and_return([@item_2, @item_1])
      visit "/merchants/#{@merchant.id}/items"

      within('#top-items') do
        expect(page).to have_content("Top Items")
        expect(@item_2.name).to appear_before(@item_1.name)
      end
    end
  end
end
