# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

require 'rails_helper'

RSpec.describe "Merchant Item's edit Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_2 = @merchant.items.create!(name: "orange",
                                      description: "same name as the color wow!",
                                      unit_price: 2.09)
  end
  describe "After I clicked the update link I'm taken to a page with a form filled in with the existing item attribute information" do
    it "has a header that reads Update Item Isnformation" do
      visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

      within(".header") do
        expect(page).to have_content("Update Item Information")
      end

      within(".form") do
        expect(page).to have_content("Name")
        expect(page).to have_content("Description")
        expect(page).to have_content("Unit price")
      end
    end

    it "updates the information in the form when I click submit and I'm redirected back to the item show page which shows updates info" do
      visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

      within(".form") do
        fill_in :description, with: "These are the best fucking apples I've ever tasted"
        fill_in :unit_price, with: 1.50
        click_on 'Update Item'
      end

      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    end
  end
end
