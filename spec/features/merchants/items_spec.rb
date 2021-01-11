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

    describe "the five most popular items" do
      it "ranked by total revenue" do
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

      it "with their best sales day" do
        merchant1 = create(:merchant)
        items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

        5.times do |index|
          invoice = create(:invoice, created_at: Date.today - index)
          items[0..index].each do |item|
            create(:invoice_item, item: item, invoice: invoice, quantity: (5 - index), unit_price: 1)
          end
          create(:transaction, invoice: invoice, result: 0)
        end

        visit merchant_items_path(merchant1)

        within("#top_items") do
          items.each_with_index do |item, index|
            top_day = "Top selling date for #{item.name} was #{(Date.today-index).strftime("%A, %B %-d, %Y")}"
            expect(page).to have_content(top_day)
          end
        end
      end

      it "showing the most recent day if multiple days have the top sales" do
        merchant1 = create(:merchant)
        items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

        5.times do |index|
          invoice = create(:invoice, created_at: Date.today - index)
          items[index..-1].each do |item|
            create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 1)
          end
          create(:transaction, invoice: invoice, result: 0)
        end

        visit merchant_items_path(merchant1)

        within("#top_items") do
          items.each do |item|
            top_day = "Top selling date for #{item.name} was #{Date.today.strftime("%A, %B %-d, %Y")}"
            expect(page).to have_content(top_day)
          end
        end
      end
    end

    it "link to create new item" do
      merchant1 = create(:merchant)
      visit merchant_items_path(merchant1)

      expect(page).to have_link("New Item", href: new_merchant_item_path(merchant1))
    end

    it "enabled/disabled items in their own sections" do
      merchant1 = create(:merchant)
      enabled_item = create(:item, merchant: merchant1)
      disabled_item = create(:item, merchant: merchant1, enabled: false)
      visit merchant_items_path(merchant1)

      within("#enabled") {expect(page).to have_content(enabled_item.name)}
      within("#disabled") {expect(page).to have_content(disabled_item.name)}
    end
  end

  describe 'can disable/enable' do
    it "items" do
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
