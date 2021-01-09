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
        expect(page).to have_link(item.name, href: item_path(item))
      end
      merchant2.items.each do |item|
        expect(page).not_to have_content(item.name)
      end
    end
  end
  describe 'can disable/enable' do
    it "items" do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)
      # false_item = create(:item, merchant: merchant1, enabled: false)
      visit merchant_items_path(merchant1)

      2.times do
        within "#enabled-item-1" do
          expect(page).to have_button("Disable")
          expect(page).to have_content(item.name)
          click_button "Disable"
          expect(current_path).to eq(merchant_items_path(merchant1))
        end
        within "#disabled-item-1" do
          expect(page).to have_button("Enable")
          expect(page).to have_content(item.name)
          click_button "Enable"
          expect(current_path).to eq(merchant_items_path(merchant1))
        end
      end
    end
  end
end
