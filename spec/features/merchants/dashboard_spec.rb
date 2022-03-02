require 'rails_helper'

RSpec.describe 'merchant dashboard' do
    it 'displays the name of a merchant' do
        merchant = create(:merchant)

        visit "/merchants/#{merchant.id}/dashboard"

        expect(page).to have_content(merchant.name)
    end

    it 'has links to items index and invoices index' do
        merchant = create(:merchant)

        visit "/merchants/#{merchant.id}/dashboard"

        expect(page).to have_link("My Items")
        expect(page).to have_link("My Invoices")

    end

    it 'has top 5 customers and number of transactions for each' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        customer_1 = create(:customer)
        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id)

        customer_2 = create(:customer)
        invoice_2 = create(:invoice, customer_id: customer_2.id)
        invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)
        transaction_3 = create(:transaction, invoice_id: invoice_2.id)

        customer_3 = create(:customer)
        invoice_3 = create(:invoice, customer_id: customer_3.id)
        invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
        transaction_4 = create(:transaction, invoice_id: invoice_3.id)
        transaction_5 = create(:transaction, invoice_id: invoice_3.id)
        transaction_6 = create(:transaction, invoice_id: invoice_3.id)

        customer_4 = create(:customer)
        invoice_4 = create(:invoice, customer_id: customer_4.id)
        invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
        transaction_7 = create(:transaction, invoice_id: invoice_4.id)
        transaction_8 = create(:transaction, invoice_id: invoice_4.id)
        transaction_9 = create(:transaction, invoice_id: invoice_4.id)
        transaction_10 = create(:transaction, invoice_id: invoice_4.id)
        transaction_21 = create(:transaction, invoice_id: invoice_4.id)

        customer_5 = create(:customer)
        invoice_5 = create(:invoice, customer_id: customer_5.id)
        invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id)
        transaction_11 = create(:transaction, invoice_id: invoice_5.id)
        transaction_12 = create(:transaction, invoice_id: invoice_5.id)
        transaction_13 = create(:transaction, invoice_id: invoice_5.id)
        transaction_14 = create(:transaction, invoice_id: invoice_5.id)

        customer_6 = create(:customer)
        invoice_6 = create(:invoice, customer_id: customer_6.id)
        invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id)
        transaction_15 = create(:transaction, invoice_id: invoice_6.id)
        transaction_16 = create(:transaction, invoice_id: invoice_6.id)
        transaction_17 = create(:transaction, invoice_id: invoice_6.id)
        transaction_18 = create(:transaction, invoice_id: invoice_6.id)
        transaction_19 = create(:transaction, invoice_id: invoice_6.id)
        transaction_20 = create(:transaction, invoice_id: invoice_6.id)

        visit "/merchants/#{merchant.id}/dashboard"

        within("#favorite_customers") do
            expect(page).to have_content("Favorite Customers")
            expect(page).to have_content(customer_6.first_name)
            expect(page).to have_content(customer_5.first_name)
            expect(page).to have_content(customer_4.first_name)
            expect(page).to have_content(customer_3.first_name)
            expect(page).to have_content(customer_2.first_name)
            expect(page).to_not have_content(customer_1.first_name)
            expect(page).to have_content(Customer.transaction_count(customer_4.id))
            expect(page).to have_content(Customer.transaction_count(customer_5.id))
            expect(page).to have_content(Customer.transaction_count(customer_6.id))
            expect(page).to have_content(Customer.transaction_count(customer_3.id))
            expect(page).to have_content(Customer.transaction_count(customer_2.id))

            expect(customer_6.first_name).to appear_before(customer_4.first_name)
            expect(customer_4.first_name).to appear_before(customer_5.first_name)
            expect(customer_5.first_name).to appear_before(customer_3.first_name)
            expect(customer_3.first_name).to appear_before(customer_2.first_name)
        end
    end

    it 'lists items ready to ship with links to invoice show page' do
        merchant = create(:merchant)
        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)
        item_3 = create(:item, merchant_id: merchant.id)
        item_4 = create(:item, merchant_id: merchant.id)
        item_5 = create(:item, merchant_id: merchant.id)

        customer_1 = create(:customer)
        invoice_1 = create(:invoice, customer_id: customer_1.id, status: 0)
        invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_1 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, status: 1)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id)

        customer_2 = create(:customer)
        invoice_2 = create(:invoice, customer_id: customer_2.id, status: 0)
        invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
        invoice_item_2 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, status: 1)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        customer_3 = create(:customer)
        invoice_3 = create(:invoice, customer_id: customer_3.id, status: 0)
        invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 1)
        invoice_item_3 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, status: 1)
        invoice_item_3 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_3.id, status: 1)
        transaction_4 = create(:transaction, invoice_id: invoice_3.id)

        customer_4 = create(:customer)
        invoice_4 = create(:invoice, customer_id: customer_4.id, status: 0)
        invoice_item_4 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_4.id, status: 1)
        transaction_7 = create(:transaction, invoice_id: invoice_4.id)

        customer_5 = create(:customer)
        invoice_5 = create(:invoice, customer_id: customer_5.id, status: 0)
        invoice_item_5 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_5.id, status: 1)
        transaction_11 = create(:transaction, invoice_id: invoice_5.id)

        customer_6 = create(:customer)
        invoice_6 = create(:invoice, customer_id: customer_6.id, status: 0)
        invoice_item_6 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_6.id, status: 1)
        transaction_15 = create(:transaction, invoice_id: invoice_6.id)

        visit "/merchants/#{merchant.id}/dashboard"

        within("#ready_to_ship") do
            expect(page).to have_content("Items Ready to Ship")
            expect(page).to have_content("#{item_1.name} - Invoice ##{invoice_1.id}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_1.id}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_2.id}")
            expect(page).to have_content("#{item_3.name} - Invoice ##{invoice_3.id}")
            expect(page).to have_content("#{item_4.name} - Invoice ##{invoice_3.id}")
            expect(page).to have_content("#{item_5.name} - Invoice ##{invoice_3.id}")
            expect(page).to have_content("#{item_1.name} - Invoice ##{invoice_4.id}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_5.id}")
            expect(page).to have_content("#{item_3.name} - Invoice ##{invoice_6.id}")
            expect(page).to have_link("Invoice ##{invoice_1.id}")
            expect(page).to have_link("Invoice ##{invoice_2.id}")
            expect(page).to have_link("Invoice ##{invoice_3.id}")
            expect(page).to have_link("Invoice ##{invoice_4.id}")
            expect(page).to have_link("Invoice ##{invoice_5.id}")
            expect(page).to have_link("Invoice ##{invoice_6.id}")
        end
    end

    it 'ready to ship section includes date of invoice and ordered from oldest to newest' do
        merchant = create(:merchant)
        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)
        item_3 = create(:item, merchant_id: merchant.id)
        item_4 = create(:item, merchant_id: merchant.id)
        item_5 = create(:item, merchant_id: merchant.id)

        customer_1 = create(:customer)
        invoice_1 = create(:invoice, customer_id: customer_1.id, status: 0)
        invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_1 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, status: 1)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id)

        customer_2 = create(:customer)
        invoice_2 = create(:invoice, customer_id: customer_2.id, status: 0)
        invoice_item_2 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, status: 1)
        invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        customer_3 = create(:customer)
        invoice_3 = create(:invoice, customer_id: customer_3.id, status: 0)
        invoice_item_3 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_3.id, status: 1)
        invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 1)
        invoice_item_3 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, status: 1)
        transaction_4 = create(:transaction, invoice_id: invoice_3.id)

        customer_4 = create(:customer)
        invoice_4 = create(:invoice, customer_id: customer_4.id, status: 0)
        invoice_item_4 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_4.id, status: 1)
        transaction_7 = create(:transaction, invoice_id: invoice_4.id)

        customer_5 = create(:customer)
        invoice_5 = create(:invoice, customer_id: customer_5.id, status: 0)
        invoice_item_5 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_5.id, status: 1)
        transaction_11 = create(:transaction, invoice_id: invoice_5.id)

        customer_6 = create(:customer)
        invoice_6 = create(:invoice, customer_id: customer_6.id, status: 0)
        invoice_item_6 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_6.id, status: 1)
        transaction_15 = create(:transaction, invoice_id: invoice_6.id)

        visit "/merchants/#{merchant.id}/dashboard"


        within("#ready_to_ship") do 

            date = Time.current
            expect(page).to have_content("#{item_1.name} - Invoice ##{invoice_1.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_1.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_2.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_3.name} - Invoice ##{invoice_3.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_4.name} - Invoice ##{invoice_3.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_5.name} - Invoice ##{invoice_3.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_1.name} - Invoice ##{invoice_4.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_2.name} - Invoice ##{invoice_5.id} - #{date.strftime('%A, %B %d, %Y')}")
            expect(page).to have_content("#{item_3.name} - Invoice ##{invoice_6.id} - #{date.strftime('%A, %B %d, %Y')}")

        end
    end
end
