require 'rails_helper'

RSpec.describe "Items Index" do
  describe 'displays' do
    it "merchant's items" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      create_list(:item, 3, merchant: merchant1)
      create_list(:item, 3, merchant: merchant2)

      visit merchant_items_path(merchant1)

      merchant1.items.each do |item|
        expect(page).to have_content(item.name)
      end
      merchant2.items.each do |item|
        expect(page).not_to have_content(item.name)
      end
    end
  end
end
