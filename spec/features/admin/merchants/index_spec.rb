require 'rails_helper'

RSpec.describe 'admin merchant index' do 
    let(:first) {'Schroeder-Jerde</a>'} 
    let(:second) {'Bobs Cranes</a>'}
    it 'shows the name of each merchant in the system' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now)
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now)
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now)
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now)

        visit '/admin/merchants'

        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
        expect(page).to have_content("#{merchant_4.name}")
        expect(page).to have_content("#{merchant_5.name}")
    end 

     it 'has an admin merchant show page when you click on the merchant name' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        
        visit '/admin/merchants'

        click_on("#{merchant_1.name}")

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
        expect(page).to have_content("#{merchant_1.name}")
    end 

    it 'has two sections - enabled and disabled - with a button next to each merchant based on category' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now)
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now)
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now)
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now, status: "enabled")

        visit '/admin/merchants'

        within (".disabled_merchants") do 
            expect(page).to have_button("Enable")
            expect(page).to have_content("Bobs Cranes")
            expect(page).to have_content("Joe-Schmo Railroads")
            expect(page).to have_content("Allison Bugaboo")
        end 
        
          within (".enabled_merchants") do 
            expect(page).to have_button("Disable")
            expect(page).to have_content("Schroeder-Jerde")
            expect(page).to have_content("Castanza George")
        end 
    end 

    it 'has two sections - enabled and disabled - with a button next to each merchant based on category' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")

        visit '/admin/merchants'

        within (page.all(".enabled_merchant_buttons")[0]) do 
            click_button("Disable")
        end 

        within (page.all(".disabled_merchant_buttons")[0]) do 
            expect(page).to have_button("Enable")
            expect(page).to have_content("Schroeder-Jerde")

            click_button("Enable")
        end 

        within (page.all(".enabled_merchant_buttons")[0]) do 
            expect(page).to have_button("Disable")
            expect(page).to have_content("Schroeder-Jerde")
        end 
    end 

    it 'has a button to create a new merchant' do         
        visit '/admin/merchants'

        click_on("Create a new merchant")

        expect(current_path).to eq("/admin/merchants/new")
    end 

    it 'has the top 5 merchants' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_6 = Merchant.create!(name: "Ali Baba", created_at: Time.now, updated_at: Time.now, status: "enabled")

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
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_3.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_4.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_5.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_6.id, created_at: Time.now, updated_at: Time.now)


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

        visit '/admin/merchants'
        
        expect(page).to have_content("Top 5 Merchants:")
    

        expect(first).to appear_before(second)


        within ("#column2") do 
            expect(page.all('.top_5_merchants')[0]).to have_content("Ali Baba - $8,000.00")
            expect(page.all('.top_5_merchants')[1]).to have_content("Castanza George - $70.00")
            expect(page.all('.top_5_merchants')[2]).to have_content("Allison Bugaboo - $60.00")
            expect(page.all('.top_5_merchants')[3]).to have_content("Joe-Schmo Railroads - $50.00")
            expect(page.all('.top_5_merchants')[4]).to have_content("Bobs Cranes - $40.00")
        end 
    end 

    it 'has the top earning days for each merchant in the top 5 days' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_6 = Merchant.create!(name: "Ali Baba", created_at: Time.now, updated_at: Time.now, status: "enabled")

        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_5.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_5.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: "2012-03-25 09:54:09 UTC", updated_at: Time.now, customer_id: customer_5.id )
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
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_3.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_4.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_5.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_6.id, created_at: Time.now, updated_at: Time.now)

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

        visit '/admin/merchants'


        within ("#column2") do 
            expect(page.all('.top_5_merchants')[0]).to have_content("Top selling date for Ali Baba was Saturday, March 17, 2012")
            expect(page.all('.top_5_merchants')[1]).to have_content("Top selling date for Castanza George was Monday, March 26, 2012")
            expect(page.all('.top_5_merchants')[2]).to have_content("Top selling date for Allison Bugaboo was Sunday, March 25, 2012")
            expect(page.all('.top_5_merchants')[3]).to have_content("Top selling date for Joe-Schmo Railroads was Sunday, March 25, 2012")
            expect(page.all('.top_5_merchants')[4]).to have_content("Top selling date for Bobs Cranes was Sunday, March 25, 2012")
        end 
    end 
end 