require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do
  describe "when I visit the merchant items edit page" do
    it "I see form filled in with existing info" do
      merchant = Merchant.create!(name: "Paul the Merchant")
      item1 = merchant.items.create!(name: "Paul's Item",
                                     description: "Paul's very popular item",
                                     unit_price: "2500")
      visit "/merchants/#{merchant.id}/items/#{item1.id}/edit"

      expect(page).to have_field(:item_unit_price, with: 2500)
      expect(page).to have_field(:item_name, with: item1.name)
      expect(page).to have_field(:item_description, with: item1.description)
    end

    it "When the form is filled out and submitted, I am redirected to the show page and the updated info is there" do
      merchant = Merchant.create!(name: "Paul the Merchant")
      item1 = merchant.items.create!(name: "Paul's Item",
                                     description: "Paul's very popular item",
                                     unit_price: "2500")
      visit "/merchants/#{merchant.id}/items/#{item1.id}/edit"

      within("#update_item") do
        fill_in 'item_unit_price', with: 10
        click_on 'Update Item'
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item1.id}")
      item1.reload
      expect(item1.unit_price).to eq(10)
      # expect(page).to have_content("Item Successfully Updated")
      #comeback to test for flash message when you are smarter
    end
  end
end
