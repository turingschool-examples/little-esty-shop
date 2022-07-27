require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  it 'has the name of the merchant' do
    merchant = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "REI")
    
    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content("Wizards Chest")
    expect(page).to_not have_content("REI")
  end

  it 'has links to merchant items index and merchant invoices index' do
    merchant = Merchant.create!(name: "Wizards Chest")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link("My Items")
    click_link("My Items")
    expect(current_path).to eq("/merchants/#{merchant.id}/items")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link("My Invoices")
    click_link("My Invoices")
    expect(current_path).to eq("/merchants/#{merchant.id}/invoices")
  end

  it 'shows fav customers names - top 5 by number of successful transactions' do
    customer_1 = Customer.create!(first_name: "A", last_name: "A")
    customer_2 = Customer.create!(first_name: "B", last_name: "B")
    customer_3 = Customer.create!(first_name: "C", last_name: "C")
    customer_4 = Customer.create!(first_name: "D", last_name: "D")
    customer_5 = Customer.create!(first_name: "E", last_name: "E")
    customer_6 = Customer.create!(first_name: "F", last_name: "F")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer_2.id)
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer_3.id)
    invoice_4 = Invoice.create!(status: "completed", customer_id: customer_4.id)
    invoice_5 = Invoice.create!(status: "completed", customer_id: customer_5.id)
    invoice_6 = Invoice.create!(status: "completed", customer_id: customer_6.id)

    transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_6 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_7 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_8 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_9 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
    transaction_10 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_11 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_12 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_13 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
    transaction_14 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
    transaction_15 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
    transaction_16 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_17 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
    transaction_18 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
    transaction_19 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_20 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
    transaction_21 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      
    merchant = Merchant.create!(name: "Wizards Chest")

    item = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)

    invoice_item_1 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_1.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_2 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_2.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_3 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_4 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_5 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_6 = InvoiceItem.create!(item_id: item.id, invoice_id: invoice_6.id, status: "shipped", quantity: 5, unit_price: 100)

    visit "/merchants/#{merchant.id}/dashboard"

    within "#favorite-customers" do
      expect(page).to have_content("Favorite Customers")
      expect(page).to have_content("1. F F - 5 purchases")
      expect(page).to have_content("2. E E - 4 purchases")
      expect(page).to have_content("3. D D - 3 purchases")
      expect(page).to have_content("4. C C - 2 purchases")
      expect(page).to have_content("5. B B - 1 purchases")
    end
  end

  it 'shows items ready to ship names, invoice id link and formatted date invoice created ordered oldest to newest' do
    customer_1 = Customer.create!(first_name: "A", last_name: "A")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2022-07-22 00:00:00 UTC")
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2022-07-23 00:00:00 UTC")
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2022-07-24 00:00:00 UTC")
    invoice_4 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2022-07-25 00:00:00 UTC")
    invoice_5 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2022-07-26 00:00:00 UTC")

    merchant = Merchant.create!(name: "Wizards Chest")

    item_1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
    item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)
    item_3 = Item.create!(name: "C", description: "C", unit_price: 300, merchant_id: merchant.id)
    item_4 = Item.create!(name: "D", description: "D", unit_price: 400, merchant_id: merchant.id)
    item_5 = Item.create!(name: "E", description: "E", unit_price: 500, merchant_id: merchant.id)

    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "packaged", quantity: 5, unit_price: 100)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "pending", quantity: 5, unit_price: 100)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 5, unit_price: 100)
    invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "pending", quantity: 5, unit_price: 100)

    visit "/merchants/#{merchant.id}/dashboard"

    within "#ready-to-ship" do
      expect(page).to have_content("Items Ready to Ship")
      expect("A - ").to appear_before("B - ")
      expect("B - ").to appear_before("E - ")
      expect(page).to_not have_content("C - ")
      expect(page).to_not have_content("D - ")
      expect(page).to have_link("Invoice ##{invoice_1.id}")
      expect(page).to have_link("Invoice ##{invoice_2.id}")
      expect(page).to have_link("Invoice ##{invoice_5.id}")

      expect("- #{invoice_1.format_date}").to appear_before("- #{invoice_2.format_date}")
      expect("- #{invoice_2.format_date}").to appear_before("- #{invoice_5.format_date}")
      expect(page).to_not have_content("- #{invoice_3.format_date}")
      expect(page).to_not have_content("- #{invoice_4.format_date}")

      click_link("Invoice ##{invoice_1.id}")
      expect(current_path).to eq("/merchants/#{merchant.id}/invoices/#{invoice_1.id}")
    end
  end
end