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

    it "the five most popular items, and their revenue, in order" do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      items.each_with_index do |item, index|
        (5 - index).times do
          invoice = create(:invoice)
          create(:invoice_item, item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: item.unit_price)
          create(:transaction, invoice_id: invoice.id, result: 0)
        end
      end

      visit merchant_items_path(merchant1)

      within '#top_items' do
        expect(page).not_to have_content(item.name)
        items.each_with_index do |item, index|
          within "#top-#{index + 1}" do
            expect(page).to have_link(item.name, href: item_path(item))
            expect(page).to have_content("$ #{5 - index}")
          end
        end
      end
    end

    it "link to create new item" do
      merchant1 = create(:merchant)
      visit merchant_items_path(merchant1)

      expect(page).to have_link("New Item", href: new_merchant_item_path(merchant1))
    end

    it "items in the right order" do
      merchant1 = create(:merchant)
      enabled_item = create(:item, merchant: merchant1)
      disabled_item = create(:item, merchant: merchant1, enabled: false)
      visit merchant_items_path(merchant1)

      expect(enabled_item.name).to appear_before(disabled_item.name)
    end
  end

  describe 'can disable/enable' do
    it " items" do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)
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
