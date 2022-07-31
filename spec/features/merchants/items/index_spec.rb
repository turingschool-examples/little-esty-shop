require 'rails_helper'

RSpec.describe 'items index page' do
  it 'displays a list of the names of all the merchants items and nothing from other merchants' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_7 = Item.create!(name: "Cowboy Hat", description: "Yehaw", unit_price: 9000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_5.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_6.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)

    visit merchant_items_path(merchant_1)

    expect(page).to have_content("Watch")
    expect(page).to have_content("Crocs")
    expect(page).to have_content("Beanie")
    expect(page).to have_content("Socks")
    expect(page).to have_content("Necklace")
    expect(page).to have_content("Wallet")
    expect(page).to_not have_content("Cowboy Hat")
  end

  it 'can disable and enable an item' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_7 = Item.create!(name: "Cowboy Hat", description: "Yehaw", unit_price: 9000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_5.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_6.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)

    visit merchant_items_path(merchant_1)

      within "#disabled" do
        within "#item-#{item_1.id}" do
          expect(page).to_not have_button("Disable")
          click_button("Enable")
          expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        end
      end
      within "#enabled" do
        within "#item-#{item_1.id}" do
          expect(page).to_not have_button("Enable")
          click_button("Disable")
          expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        end
      end
    end

    it "lists the 5 most popular items by revenue" do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_7 = Item.create!(name: "Cowboy Hat", description: "Yehaw", unit_price: 9000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_5.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_6.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)

      visit merchant_items_path(merchant_1)

      within "#top_5_items" do
      expect(item_6.name).to appear_before(item_5.name)
      expect(item_5.name).to appear_before(item_4.name)
      expect(item_4.name).to appear_before(item_3.name)
      expect(page).to_not have_content(item_1.name)

      expect(page).to have_content("Total Revenue: $8000")
      expect(page).to have_content("Total Revenue: $7000")
      expect(page).to have_content("Total Revenue: $6000")
      expect(page).to have_content("Total Revenue: $5000")
      expect(page).to have_content("Total Revenue: $4000")
    end
  end

  it 'shows the top selling day for each item' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_7 = Item.create!(name: "Cowboy Hat", description: "Yehaw", unit_price: 9000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_5.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_6.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)

      visit merchant_items_path(merchant_1)

      within "#top_5_items" do
      expect(page).to have_content("Top day for #{item_6.top_earning_day.strftime("%-m/%d/%y")}")
      expect(page).to have_content("Top day for #{item_5.top_earning_day.strftime("%-m/%d/%y")}")
      expect(page).to have_content("Top day for #{item_4.top_earning_day.strftime("%-m/%d/%y")}")
      expect(page).to have_content("Top day for #{item_3.top_earning_day.strftime("%-m/%d/%y")}")
      expect(page).to have_content("Top day for #{item_2.top_earning_day.strftime("%-m/%d/%y")}")
    end
  end

end
