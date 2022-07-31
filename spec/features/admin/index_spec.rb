require 'rails_helper'

RSpec.describe 'admin index' do 

    it 'has an index page' do 
        visit '/admin'

        expect(page).to have_content("Admin Dashboard")
    end 

    it 'has a link to a merchant index' do 
        visit '/admin'

        expect(page).to have_content("Merchants")

        click_on("Merchants")

        expect(current_path).to eq('/admin/merchants')
    end 

    it 'has a link to a merchant index' do 
        visit '/admin'

        expect(page).to have_content("Invoices")

        click_on("Invoices")

        expect(current_path).to eq('/admin/invoices')
    end 

    it 'see the names of top 5 customers' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_5.id )
        invoice_5 = Invoice.create!(status: :completed, created_at: "2012-03-26 06:54:10 UTC", updated_at: Time.now, customer_id: customer_5.id )
        invoice_6 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_4.id )
        invoice_7 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_4.id )
        invoice_8 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_4.id )
        invoice_9 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_4.id )
        invoice_10 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_3.id )
        invoice_11 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_3.id )
        invoice_12 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_3.id )
        invoice_13 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_2.id )
        invoice_14 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_2.id )
        invoice_15 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_1.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)


        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_7.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_8 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_8.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_9 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_9.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_10 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_10.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_11 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_11.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_12 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_12.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_13 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_13.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_14 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_14.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
        invoice_item_15 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_15.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )
        transaction_7 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_7.id )
        transaction_8 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_8.id )
        transaction_9 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_9.id )
        transaction_10 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_10.id )
        transaction_11 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_11.id )
        transaction_12 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_12.id )
        transaction_13 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_13.id )
        transaction_14 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_14.id )
        transaction_15 = Transaction.create!(credit_card_number:4449555566667777, result: "success",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_15.id )

        visit '/admin'

        expect(page).to have_content("Top 5 Customers")

        within ("#column1") do 
            expect(page.all('.customer')[0]).to have_content("#{customer_5.first_name} #{customer_5.last_name} - 5")
            expect(page.all('.customer')[1]).to have_content("#{customer_4.first_name} #{customer_4.last_name} - 4")
            expect(page.all('.customer')[2]).to have_content("#{customer_3.first_name} #{customer_3.last_name} - 3")
            expect(page.all('.customer')[3]).to have_content("#{customer_2.first_name} #{customer_2.last_name} - 2")
            expect(page.all('.customer')[4]).to have_content("#{customer_1.first_name} #{customer_1.last_name} - 1")

        end 
    
    end 

    it 'sees a section for incomplete invoices' do 
        visit '/admin'
        expect(page).to have_content("Incomplete Invoices")
    end 

    it 'sees a list of all the ids of all invoices that have items that have not been shipped' do 

        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_4.id )
        invoice_5 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_6 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_6.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)


        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )

        visit '/admin'

        within ("#column2") do 
            expect(page.all('.invoice')[0]).to have_content("Id: #{invoice_4.id}")
            expect(page.all('.invoice')[1]).to have_content("Id: #{invoice_5.id}")
            expect(page.all('.invoice')[2]).to have_content("Id: #{invoice_6.id}")
        end 
    end 

    it 'links to invoice admin show page' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_4.id )
        invoice_5 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_6 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_6.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)


        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )
        
        visit '/admin'
        
        within ("#column2") do
            click_on("#{invoice_4.id}")
        end 
        expect(current_path).to eq("/admin/invoices/#{invoice_4.id}")
    end 

    it 'shows the date the incomplete invoice was created and in order from oldest to newest' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_4.id )
        invoice_5 = Invoice.create!(status: :completed, created_at: "2012-03-26 06:54:10 UTC", updated_at: Time.now, customer_id: customer_5.id )
        invoice_6 = Invoice.create!(status: :completed, created_at: "2012-03-17 08:54:11 UTC", updated_at: Time.now, customer_id: customer_6.id )

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)


        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )
        
        visit '/admin'
        
        within ("#column2") do 
            expect(page.all('.invoice')[0]).to have_content("Saturday, March 17, 2012")
            expect(page.all('.invoice')[1]).to have_content("Sunday, March 25, 2012")
            expect(page.all('.invoice')[2]).to have_content("Monday, March 26, 2012")
        end 
    end 
end 
