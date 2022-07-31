require 'rails_helper'

RSpec.describe 'admin invoice show page' do 

    it "shows the item on an admin invoice show page" do

        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
    

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: item_2.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 4, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

        visit "admin/invoices/#{invoice_1.id}"
        
        within("#items") do
        
            expect(page.all(".item")[0]).to have_content("Watch")
            expect(page.all(".item")[0]).to have_content("Quantity: 1")
            expect(page.all(".item")[0]).to have_content("Price: $30.00")
            expect(page.all(".item")[0]).to have_content("Status: shipped") 

            expect(page.all(".item")[1]).to have_content("Crocs")
            expect(page.all(".item")[1]).to have_content("Quantity: 2")
            expect(page.all(".item")[1]).to have_content("Price: $40.00")
            expect(page.all(".item")[1]).to have_content("Status: pending") 
        end
    end

    it "shows the total revenue that will be generate by this invoice" do

        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
    

        invoice_1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: item_2.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 4, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)


        visit "admin/invoices/#{invoice_1.id}"
        expect(page).to have_content("Total Revenue: $1,330.00")   
    end


    it " shows a select field for invoice status" do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
    

        invoice_1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: item_2.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 4, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
    
        visit "admin/invoices/#{invoice_1.id}"


        select('cancelled', from: 'invoice[status]')

        click_button('Update invoice status')

        expect(page).to_not have_content('Invoice status: completed')
        expect(page).to have_content('Invoice status: cancelled')
    end
end