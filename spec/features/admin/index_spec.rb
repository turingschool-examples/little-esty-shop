require 'rails_helper'

RSpec.describe "admin dashboard" do
    it 'has an admin dashboard header ' do

      visit("/admin")

      expect(page).to have_content("Admin Dashboard")
    end

    it "has links to the merchants index and the invoices index" do

      visit("/admin")

      click_on("Merchants")
      expect(current_path).to eq("/admin/merchants")

      visit("/admin")

      click_on("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end

    it "displays the top 5 customers with transacitons" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 700, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 900, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 1000, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Table Saw", description: "Steel, hand held", unit_price: 900, merchant_id: merchant_1.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")
      customer_5 = Customer.create!(first_name: "Brian", last_name: "Long")
      customer_6 = Customer.create!(first_name: "Mark", last_name: "Dole")

      invoice_1 = Invoice.create!(status: 2, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 2, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 2, customer_id: customer_5.id)
      invoice_6 = Invoice.create!(status: 0, customer_id: customer_6.id)

      transaction_1 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_2 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_3 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_4 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_5 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_6 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")

      transaction_7 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_8 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_9 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_10 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_11 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")

      transaction_12 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_13 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_14 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_15 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")

      transaction_16 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")
      transaction_17 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")
      transaction_18 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")

      transaction_19 = Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "744589654")
      transaction_20 = Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "744589654")

      transaction_21 = Transaction.create!(result: 0, invoice_id: invoice_6.id, credit_card_number: "347895454")
      transaction_22 = Transaction.create!(result: 1, invoice_id: invoice_6.id, credit_card_number: "347895454")

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 2, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_3.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 2, item_id: item_4.id, invoice_id: invoice_4.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_5.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_6.id)

      visit("/admin")

      within '#customer0' do
          expect(page).to have_content("David Smith")
          expect(page).to_not have_content("Cindy Lou")
          expect(page).to have_content("6 Purchases")
          expect(page).to_not have_content("5 Purchases")
      end

      within '#customer1' do
        expect(page).to have_content("Cindy Lou")
        expect(page).to_not have_content("David Smith")
        expect(page).to have_content("5 Purchases")
        expect(page).to_not have_content("4 Purchases")
      end

      within '#customer2' do
        expect(page).to have_content("John Johnson")
        expect(page).to_not have_content("Cindy Lou")
        expect(page).to have_content("4 Purchases")
        expect(page).to_not have_content("3 Purchases")
      end

      within '#customer3' do
        expect(page).to have_content("Mary Vale")
        expect(page).to_not have_content("Cindy Lou")
        expect(page).to have_content("3 Purchases")
        expect(page).to_not have_content("2 Purchases")
      end

      within '#customer4' do
        expect(page).to have_content("Brian Long")
        expect(page).to_not have_content("Cindy Lou")
        expect(page).to have_content("2 Purchases")
        expect(page).to_not have_content("3 Purchases")
      end
    end

    it "displays incomplete invoices" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Roberts Loggings")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 300, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 400, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Hammer", description: "Carpenter's hammer, wood handle", unit_price: 600, merchant_id: merchant_2.id )
      item_6 = Item.create!(name: "Speed Square", description: "Metal w/ level", unit_price: 700, merchant_id: merchant_2.id )
      item_7 = Item.create!(name: "Mallet", description: "Wooden carpenter's mallet", unit_price: 800, merchant_id: merchant_2.id )
      item_8 = Item.create!(name: "Reciprocating Saw", description: "Electric reciprocating saw", unit_price: 900, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")

      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2001), customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, created_at: Time.new(2002),customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 0, created_at: Time.new(2003),customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, created_at: Time.new(2004),customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 1, created_at: Time.new(2005),customer_id: customer_4.id)
      invoice_6 = Invoice.create!(status: 2, created_at: Time.new(2000),customer_id: customer_4.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 200, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 300, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 400, status: 2, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 500, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 600, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 700, status: 0, item_id: item_6.id, invoice_id: invoice_3.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 800, status: 2, item_id: item_7.id, invoice_id: invoice_4.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 2, item_id: item_8.id, invoice_id: invoice_4.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 0, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 0, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_11 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_6.id)
      invoice_item_12 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_6.id)

      visit("/admin")

      expect(page).to have_content("Incomplete Invoices")

      within '#invoice0' do
        expect(page).to have_content("Invoice ##{invoice_6.id}")
        expect(page).to have_content("#{invoice_6.created_at.strftime("%A, %B%e, %Y")}")
      end
      within '#invoice1' do
        expect(page).to have_content("Invoice ##{invoice_1.id}")
        expect(page).to have_content("#{invoice_1.created_at.strftime("%A, %B%e, %Y")}")
      end
      within '#invoice2' do
        expect(page).to have_content("Invoice ##{invoice_2.id}")
        expect(page).to have_content("#{invoice_2.created_at.strftime("%A, %B%e, %Y")}")
      end
      within '#invoice3' do
        expect(page).to have_content("Invoice ##{invoice_3.id}")
        expect(page).to have_content("#{invoice_3.created_at.strftime("%A, %B%e, %Y")}")

      end
      within '#invoice4' do
        expect(page).to have_content("Invoice ##{invoice_5.id}")
        expect(page).to have_content("#{invoice_5.created_at.strftime("%A, %B%e, %Y")}")
      end
    end

end
