require 'rails_helper'

RSpec.describe "New Item" do
  describe 'makes' do
    it "the item's attributes" do
      merchant1 = create(:merchant)

      visit merchant_items_path(merchant1)
      click_link "New Item"

      fill_in("item[name]", with: "LOUD ONION")
      fill_in("item[description]", with: "makes u cry")
      fill_in("item[unit_price]", with: 100)
      click_button("Create")

      expect(current_path).to eq(merchant_items_path(merchant1))
      expect(page).to have_content("LOUD ONION")
    end
  end
end
