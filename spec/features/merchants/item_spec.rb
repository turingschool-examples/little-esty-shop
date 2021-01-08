require 'rails_helper'

RSpec.describe "Items Index" do
  describe 'displays' do
    it "the item's attributes" do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)

      visit item_path(item)

      expect(page).to have_content(item.name)
      expect(page).to have_content("Description: #{item.description}")
      expect(page).to have_content("Price: #{item.unit_price}")
    end

    it "an update button" do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)

      visit item_path(item)

      expect(page).to have_link("Update", href: edit_item_path(item))
    end
  end
end
