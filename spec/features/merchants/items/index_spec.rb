require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do

  it 'list all the names of items for the specific merchant' do
    merchant1 = Merchant.create!(name: 'merchant1')
    merchant2 = Merchant.create!(name: 'merchant2')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)
    item2 = merchant1.items.create!(name: 'item2', description: 'coolest item ever2', unit_price: 20000)
    item3 = merchant1.items.create!(name: 'item3', description: 'coolest item ever3', unit_price: 30000)
    item4 = merchant2.items.create!(name: 'item4', description: 'coolest item ever4', unit_price: 40000)

    visit merchant_items_path(merchant1)

    within ".merchant" do
      expect(page).to have_content("#{merchant1.name}'s Items")
      expect(page).to have_content("#{item1.name}")
      expect(page).to have_content("#{item2.name}")
      expect(page).to have_content("#{item3.name}")
      expect(page).to_not have_content("#{item4.name}")
    end
  end

  it "each item on page is a link to that item's show page" do
    merchant1 = Merchant.create!(name: 'merchant1')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)
    item2 = merchant1.items.create!(name: 'item2', description: 'coolest item ever2', unit_price: 20000)
    item3 = merchant1.items.create!(name: 'item3', description: 'coolest item ever3', unit_price: 30000)

    visit merchant_items_path(merchant1)
    within ".merchant" do
      expect(page).to have_link("#{item1.name}")
      expect(page).to have_link("#{item2.name}")
      expect(page).to have_link("#{item3.name}")
      click_link "#{item1.name}"
      expect(current_path).to eq(merchant_item_path(merchant1, item1))
    end
  end

  it "has button to disable or enable an item(next to every item)" do
    merchant1 = Merchant.create!(name: 'merchant1')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)
    item2 = merchant1.items.create!(name: 'item2', description: 'coolest item ever2', unit_price: 20000)
    item3 = merchant1.items.create!(name: 'item3', description: 'coolest item ever3', unit_price: 30000)
    visit merchant_items_path(merchant1)

    find("#disable-#{item1.id}").click
    within '.disabled-items' do
      expect(page).to have_content(item1.name)
    end

    find("#enable-#{item1.id}").click
    
    within '.enabled-items' do
      expect(page).to have_content(item1.name)
    end
  end
  it 'displays top 5 best selling items' do
    merchant = Merchant.create!(name: 'merchant name')
      item_1 = Item.create!(merchant_id: merchant.id, name: 'widget-1', description: 'widget description', unit_price: 100)
      item_2 = Item.create!(merchant_id: merchant.id, name: 'widget-2', description: 'widget description', unit_price: 200)
      item_3 = Item.create!(merchant_id: merchant.id, name: 'widget-3', description: 'widget description', unit_price: 300)
      item_4 = Item.create!(merchant_id: merchant.id, name: 'widget-4', description: 'widget description', unit_price: 400)
      item_5 = Item.create!(merchant_id: merchant.id, name: 'widget-5', description: 'widget description', unit_price: 500)
      item_6 = Item.create!(merchant_id: merchant.id, name: 'widget-6', description: 'widget description', unit_price: 600)
      item_7 = Item.create!(merchant_id: merchant.id, name: 'widget-7', description: 'widget description', unit_price: 700)
      item_8 = Item.create!(merchant_id: merchant.id, name: 'widget-8', description: 'widget description', unit_price: 800)
      item_9 = Item.create!(merchant_id: merchant.id, name: 'widget-9', description: 'widget description', unit_price: 900)
      item_10 = Item.create!(merchant_id: merchant.id, name: 'widget-10', description: 'widget description', unit_price: 1000)
      customer_1 = Customer.create!(first_name: 'customer', last_name: 'customer_last_name')
      invoice_1 = Invoice.create!(customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_10.id, quantity: 20,
                                           unit_price: 1000)
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_9.id, quantity: 20,
                                           unit_price: 900)
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 20,
                                           unit_price: 800)
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_7.id, quantity: 20,
                                           unit_price: 700)
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_6.id, quantity: 20,
                                           unit_price: 600)
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_5.id, quantity: 20,
                                           unit_price: 500)
      invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 20,
                                           unit_price: 400)
      invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 20,
                                           unit_price: 300)
      invoice_item_10 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 20,
                                           unit_price: 200)
      invoice_item_10 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 20,
                                           unit_price: 100)
      Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09", invoice_id: invoice_1.id)
      actual = Item.top_five
      Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09", invoice_id: invoice_1.id)
      visit merchant_items_path(merchant)

    within '.top-five' do
      first_item = find(".item-#{item_10.id}")
      second_item = find(".item-#{item_9.id}")
      third_item = find(".item-#{item_8.id}")
      fourth_item = find(".item-#{item_7.id}")
      fifth_item = find(".item-#{item_6.id}")
      expect(first_item).to appear_before(second_item)
      expect(second_item).to appear_before(third_item)
      expect(fourth_item).to appear_before(fifth_item)
      expect(fifth_item).to_not appear_before(first_item)

      expect(page).to have_content("#{item_10.name}-#{((invoice_item_1.quantity * invoice_item_1.unit_price).to_f / 100).to_s.ljust(6, '0').prepend('$')}")
      expect(page).to have_content("#{item_9.name}-#{((invoice_item_2.quantity * invoice_item_2.unit_price).to_f / 100).to_s.ljust(6, '0').prepend('$')}")
      expect(page).to have_content("#{item_8.name}-#{((invoice_item_3.quantity * invoice_item_3.unit_price).to_f / 100).to_s.ljust(6, '0').prepend('$')}")
      expect(page).to have_content("#{item_7.name}-#{((invoice_item_4.quantity * invoice_item_4.unit_price).to_f / 100).to_s.ljust(6, '0').prepend('$')}")
      expect(page).to have_content("#{item_6.name}-#{((invoice_item_5.quantity * invoice_item_5.unit_price).to_f / 100).to_s.ljust(6, '0').prepend('$')}")
    end
  end
end
