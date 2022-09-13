require 'rails_helper'

RSpec.describe 'Merchant dashboard' do
  describe 'as a merchant, when I visit the dashboard' do
    let(:merch_1) { Merchant.create!(name: "Bing Crosby")}
    let(:merch_2) { Merchant.create!(name: "Frank San")}

    it 'shows the name of the merchant' do
      merch_1 = Merchant.create!(name: "Bing Crosby")
      merch_2 = Merchant.create!(name: "Frank San")

      visit "/merchants/#{merch_1.id}/dashboard"

      within "#merchant_name" do
        expect(page).to have_content(merch_1.name)
        expect(page).to_not have_content(merch_2.name)
      end
    end

    it 'has a link to merchant items index' do
      visit "/merchants/#{merch_1.id}/dashboard"
      expect(page).to have_link("Go To Merchant Items Index")
    end

    it 'has a link to merchant invoices index' do
      visit "/merchants/#{merch_1.id}/dashboard"
      expect(page).to have_link("Go To Merchant Invoices Index")
    end

    describe 'favorite customers' do
      before :each do
      end
      it 'names of top 5 customers (largest number of successful transactions with merchant)' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 2)
        transact_1 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_2 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_3 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 2)
        transact_4 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_5 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_6 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_19 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_20 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        transact_7 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_8 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_9 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_21 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_4 = Customer.create!(first_name: "Yennifer", last_name: "Black")
        inv_4 = cust_4.invoices.create!(status: 1)
        inv_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_4.id, quantity: 1, unit_price: 1500, status: 2)
        transact_10 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
        transact_11 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
        transact_12 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_5 = Customer.create!(first_name: "Karl", last_name: "Blue")
        inv_5 = cust_5.invoices.create!(status: 1)
        inv_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_5.id, quantity: 1, unit_price: 1500, status: 2)
        transact_13 = inv_5.transactions.create!(credit_card_number: 4354495077693036, result: 1)
        transact_14 = inv_5.transactions.create!(credit_card_number: 3354495077694036, result: 0)
        transact_15 = inv_5.transactions.create!(credit_card_number: 2354495077693036, result: 0)
        cust_6 = Customer.create!(first_name: "Triss", last_name: "Marigold")
        inv_6 = cust_6.invoices.create!(status: 1)
        inv_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_6.id, quantity: 1, unit_price: 1500, status: 2)
        transact_16 = inv_6.transactions.create!(credit_card_number: 4354495077693036, result: 1)
        transact_17 = inv_6.transactions.create!(credit_card_number: 3354495077694036, result: 1)
        transact_18 = inv_6.transactions.create!(credit_card_number: 2354495077693036, result: 1)

        visit "/merchants/#{merch_1.id}/dashboard"
        expect(page).to have_content("Favorite Customers")
        top_five = [cust_1, cust_2, cust_3, cust_4, cust_5]

        within "#favorite_customers" do
          top_five.each do |cust|
            within "#customer_#{cust.id}" do
              expect(page).to have_content(cust.first_name)
              expect(page).to have_content(cust.last_name)
            end
          end
          expect(page).to_not have_content(cust_6.first_name)
          expect(page).to_not have_content(cust_6.last_name)
        end
      end

      it 'has the number of successful transactions next each customer name on the favorite customers list' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 2)
        transact_1 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_2 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_3 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 2)
        transact_4 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_5 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_6 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_19 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_20 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        transact_7 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_8 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_9 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        transact_21 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_4 = Customer.create!(first_name: "Yennifer", last_name: "Black")
        inv_4 = cust_4.invoices.create!(status: 1)
        inv_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_4.id, quantity: 1, unit_price: 1500, status: 2)
        transact_10 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
        transact_11 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
        transact_12 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
        cust_5 = Customer.create!(first_name: "Karl", last_name: "Blue")
        inv_5 = cust_5.invoices.create!(status: 1)
        inv_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_5.id, quantity: 1, unit_price: 1500, status: 2)
        transact_13 = inv_5.transactions.create!(credit_card_number: 4354495077693036, result: 1)
        transact_14 = inv_5.transactions.create!(credit_card_number: 3354495077694036, result: 0)
        transact_15 = inv_5.transactions.create!(credit_card_number: 2354495077693036, result: 0)
        cust_6 = Customer.create!(first_name: "Triss", last_name: "Marigold")
        inv_6 = cust_6.invoices.create!(status: 1)
        inv_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_6.id, quantity: 1, unit_price: 1500, status: 2)
        transact_16 = inv_6.transactions.create!(credit_card_number: 4354495077693036, result: 1)
        transact_17 = inv_6.transactions.create!(credit_card_number: 3354495077694036, result: 1)
        transact_18 = inv_6.transactions.create!(credit_card_number: 2354495077693036, result: 1)

        visit "/merchants/#{merch_1.id}/dashboard"
        top_five = [cust_1, cust_2, cust_3, cust_4, cust_5]
        within "#favorite_customers" do
          top_five.each do |cust|
            within "#customer_#{cust.id}" do
              #test is built so each customer only had one invoice so .first is ok
              #result of 0 means a successful transaction
              number_of_successful_transactions = cust.invoices.first.transactions.where(result: 0).count
              expect(page).to have_content(number_of_successful_transactions)
            end
          end
        end
      end
    end

    describe 'Items Ready to Ship Section' do
      it 'has a section titled Items Ready to Ship' do
        merch_1 = Merchant.create!(name: "Bing Crosby")

        visit "/merchants/#{merch_1.id}/dashboard"

        expect(page).to have_content("Items Ready to Ship")
      end

      it 'in this section are names of all items that have been ordered but not yet shipped' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        #ordered means invoice has been made, and therefore a record in invoice_items exists
        #not yet been shipped means invoice_item status is NOT 2

        visit "/merchants/#{merch_1.id}/dashboard"

        items_to_ship = [item_1, item_2]
        within "#items_to_ship" do
          items_to_ship.each do |item|
            within "#item_#{item.id}" do
              expect(page).to have_content(item.name)
            end
          end
          expect(page).to_not have_content(item_3)
        end
      end

      it 'next to each items name is the id of the invoice that ordered that item as a link to that invoice show page ' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        #ordered means invoice has been made, and therefore a record in invoice_items exists
        #not yet been shipped means invoice_item status is NOT 2

        visit "/merchants/#{merch_1.id}/dashboard"

        items_to_ship = [item_1, item_2]
        within "#items_to_ship" do
          items_to_ship.each do |item|
            within "#item_#{item.id}" do
              item_invoice_id = item.invoices.where.not(status: 2).first.id
              expect(page).to have_link("invoice #{item_invoice_id}")
              #possibly add click link test once merchant invoice show page has been added
            end
          end
          expect(page).to_not have_link("invoice #{inv_3.id}")
        end
      end

      it 'has the date that the invoice was created next to the item name' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1, created_at: 2.day.ago)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1, created_at: 1.day.ago)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        #ordered means invoice has been made, and therefore a record in invoice_items exists
        #not yet been shipped means invoice_item status is NOT 2

        visit "/merchants/#{merch_1.id}/dashboard"
save_and_open_page
require 'pry'; binding.pry
        items_to_ship = [item_1, item_2]
        within "#items_to_ship" do
          items_to_ship.each do |item|
            within "#item_#{item.id}" do
              invoice_created_date = item.invoices.where.not(status: 2).first.created_at
              expect(page).to have_content(item.invoice_created_date)
            end
          end
          expect(page).to_not have_content(inv_3.created_at)
        end
      end
      
      it 'has the invoices sorted by least recently created first' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1, created_at: 2.day.ago)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1, created_at: 1.day.ago)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
        #ordered means invoice has been made, and therefore a record in invoice_items exists
        #not yet been shipped means invoice_item status is NOT 2

        visit "/merchants/#{merch_1.id}/dashboard"

        items_to_ship = [item_1, item_2]
        within "#items_to_ship" do
          expect(item_2.name).to appear_before(item_1.name)
        end
      end
    end
  end
end