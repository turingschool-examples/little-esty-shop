require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard' do
    it 'has the name of the merchant' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content('Spongebob The Merchant')
        expect(page).to_not have_content('Jon Doe')
    end

    it 'on the merchant dashboard I see a link to my items index page' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_link('Spongebob The Merchant Item Index')
        expect(page).to_not have_content('Jon Doe Item Index')
    end

    it 'on the merchant dashboard I can click on the link and be sent to items index page' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')

        visit "/merchants/#{merchant_1.id}/dashboard"

        click_link ('Spongebob The Merchant Item Index')

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    end

    it 'on the merchant dashboard I see a link to my invoice index page' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_link('Spongebob The Merchant Invoice Index')
        expect(page).to_not have_content('Jon Doe Invoice Index')
    end

    it 'on the merchant dashboard I can click on the link and be sent to invoices index page' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')

        visit "/merchants/#{merchant_1.id}/dashboard"

        click_link ('Spongebob The Merchant Invoice Index')
        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
    end

    it 'shows the name of the top five customers ordered by most successful transactions' do
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

        visit "/merchants/#{merchant_1.id}/dashboard"

        within '#customers0' do
            expect(page).to have_content("David Smith")
            expect(page).to_not have_content("Mark Dole")
        end

        within '#customers1' do
            expect(page).to have_content("Cindy Lou")
            expect(page).to_not have_content("David Smith")
        end

        within '#customers2' do
            expect(page).to have_content("John Johnson")
            expect(page).to_not have_content("Cindy Lou")
        end

        within '#customers3' do
            expect(page).to have_content("Mary Vale")
            expect(page).to_not have_content("John Johnson")
        end

        within '#customers4' do
            expect(page).to have_content("Brian Long")
            expect(page).to_not have_content("Mark Dole")
        end
    end

    it 'next to each top customers name is their amount of successful transactions' do
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

        visit "/merchants/#{merchant_1.id}/dashboard"

        within '#customers0' do
            expect(page).to have_content("Transactions: 6")
            expect(page).to_not have_content("Transactions: 5")
        end

        within '#customers1' do
            expect(page).to have_content("Transactions: 5")
            expect(page).to_not have_content("Transactions: 6")
        end

        within '#customers2' do
            expect(page).to have_content("Transactions: 4")
            expect(page).to_not have_content("Transactions: 5")
        end

        within '#customers3' do
            expect(page).to have_content("Transactions: 3")
            expect(page).to_not have_content("Transactions: 5")
        end

        within '#customers4' do
            expect(page).to have_content("Transactions: 2")
            expect(page).to_not have_content("Transactions: 3")
        end
    end

    it 'shows a list of items that have been ordered but not shipped' do
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

        invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
        invoice_2 = Invoice.create!(status: 1, customer_id: customer_2.id)
        invoice_3 = Invoice.create!(status: 1, customer_id: customer_3.id)
        invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)

        invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 1, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
        invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_3.id, invoice_id: invoice_1.id)
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
        invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
        invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content("Items Ready to Ship")

        within '#item0' do
            expect(page).to have_content("Log")
            expect(page).to have_content(invoice_1.id)
            expect(page).to_not have_content("Saw")
            expect(page).to_not have_content(invoice_2.id)

            click_link("#{invoice_1.id}")

            expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}")
        end

        visit "/merchants/#{merchant_1.id}/dashboard"
        within '#item1' do

          expect(page).to have_content("Saw")
          expect(page).to have_content(invoice_1.id)
          expect(page).to_not have_content("Log")
          expect(page).to_not have_content(invoice_2.id)
        end

        visit "/merchants/#{merchant_1.id}/dashboard"
        within '#item2' do
          expect(page).to have_content("Axe")
          expect(page).to have_content(invoice_2.id)
          expect(page).to_not have_content("Bench")
          expect(page).to_not have_content(invoice_1.id)
        end
    end
#     Merchant Dashboard Invoices sorted by least recent
#
# As a merchant
# When I visit my merchant dashboard
# In the section for "Items Ready to Ship",
# Next to each Item name I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest
    it 'shows a list of items that have been ordered but not shipped' do
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

        invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
        invoice_2 = Invoice.create!(status: 1, created_at: Time.new(2001), customer_id: customer_2.id)
        invoice_3 = Invoice.create!(status: 1, created_at: Time.new(2002), customer_id: customer_3.id)
        invoice_4 = Invoice.create!(status: 2, created_at: Time.new(2003), customer_id: customer_4.id)

        invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 1, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
        invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_3.id, invoice_id: invoice_1.id)
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
        invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
        invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)

        visit "/merchants/#{merchant_1.id}/dashboard"
        within '#item0' do

            expect(page).to have_content("Saturday, January 1, 2000")
            expect(page).to_not have_content(invoice_2.created_at.strftime("%A, %B %e, %Y"))
        end

        within '#item1' do

          expect(page).to have_content("Saturday, January 1, 2000")
          expect(page).to_not have_content(invoice_2.created_at)
        end

        within '#item2' do
          expect(page).to have_content("Monday, January 1, 2001")
          expect(page).to_not have_content(invoice_1.created_at)
        end
    end
end
