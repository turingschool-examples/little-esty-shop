require 'rails_helper'

RSpec.describe 'merchants items index' do
  it 'lists all of the merchants items' do
    visit merchant_items_path(1)

    merchant = Merchant.find(1)
    expect(page).to have_content(merchant.name)
    merchant.items.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_link(item.name, href: merchant_item_path(1, item))
    end
    (16..174).to_a.each do |num|
      expect(page).to_not have_content(Item.find(num).name)
    end
  end

  it 'has a button to enable or disable items' do
    item = Item.find(10)
    visit merchant_items_path(1)

    within "div#item-#{item.id}" do
      expect(page).to have_button("Disable")
      click_button "Disable"
    end

    item = Item.find(10)
    expect(current_path).to eq(merchant_items_path(1))

    within "div#item-#{item.id}" do
      expect(page).to have_button("Enable")
      click_button "Enable"
    end

    item = Item.find(10)
    expect(current_path).to eq(merchant_items_path(1))

    within "div#item-#{item.id}" do
      expect(page).to have_button("Disable")
    end
  end

  it 'contains sepeartes sections for disabled and enabled items' do
    visit merchant_items_path(1)

    i = 1
    merch_items = []
    15.times do 
      merch_items << Item.find(i)
      i += 1
    end

    within "div#enabled" do
      merch_items.each do |item|
        expect(page).to have_content(item.name)
      end
    end

    within "div#item-1" do
      click_button "Disable"
    end
    within "div#item-2" do
      click_button "Disable"
    end
    within "div#item-3" do
      click_button "Disable"
    end
    within "div#item-4" do
      click_button "Disable"
    end

    within "div#disabled" do
      expect(page).to have_content(Item.find(1).name)
      expect(page).to have_content(Item.find(2).name)
      expect(page).to have_content(Item.find(3).name)
      expect(page).to have_content(Item.find(4).name)
    end
  end

  it 'has a top items section that lists top 5 items by revenue' do
    visit merchant_items_path(1)

    expect(page).to have_content("Top Items")

    within("div#top_items")do
      expect(page).to have_content(Item.find(2).name)
      expect(page).to have_content(Item.find(3).name)
      expect(page).to have_content(Item.find(6).name)
      expect(page).to have_content(Item.find(1).name)
      expect(page).to have_content(Item.find(4).name)
    end
  end
end

# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice 
# items

# Revenue for an invoice item should be calculated as the invoice item unit price 
# multiplied by the quantity (do not use the item unit price)