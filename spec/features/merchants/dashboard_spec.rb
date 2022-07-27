require 'rails_helper' 

RSpec.describe 'Merchant Dashboard' do 
    # Merchant Dashboard
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it 'has the name of the Merchant' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')
        merchant_2 = Merchant.create!(name: 'Dani Coleman')

        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page

        expect(page).to have_content('Mike Dao')
        expect(page).to_not have_content('Dani Coleman')
    end

    # Merchant Dashboard Links
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see link to my merchant items index (/merchants/merchant_id/items)
    it 'has a link to the merchant items index' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')
        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)

        # merchant_2 = Merchant.create!(name: 'Dani Coleman')
        # item_3 = merchant_2.items.create!(name: 'Glow in the dark star stickers', description: 'stickers that glow', unit_price: 1400)

        visit "merchants/#{merchant_1.id}/dashboard" 

        click_link "My Items" 

        expect(current_path).to eq "/merchants/#{merchant_1.id}/items" 
    end

    # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    it 'has a link to the merchant invoices index' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')
        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)

        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1 = customer_1.invoices.create!(status: 0)
        invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: item_1.unit_price, status: 1, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_1b = InvoiceItem.create!(quantity: 1, unit_price: item_2.unit_price, status: 2,item_id: item_2.id, invoice_id: invoice_1.id)

        invoice_2 = customer_1.invoices.create!(status: 2)
        invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: item_3.unit_price, status: 0,item_id: item_3.id, invoice_id: invoice_2.id)

        invoice_3 = customer_1.invoices.create!(status: 1)
        invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: item_3.unit_price, status: 2,item_id: item_3.id, invoice_id: invoice_3.id)

        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page

        click_link "My Invoices" 

        expect(current_path).to eq "/merchants/#{merchant_1.id}/invoices" 
    end

    # Merchant Dashboard Statistics - Favorite Customers
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    it 'displays the names of the top 5 customers' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1a)

        # transaction_1a_1 = Transaction.create!(credit_card_number: '1234', result: 'success', invoice_id: invoice_1a.id)

        transaction_1a_1 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_2 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_3 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_4 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1b = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1b)
        
        transaction_1b_1 = invoice_1b.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_2 

        customer_2 = Customer.create!(first_name: 'Carlos', last_name: 'Stich')

        invoice_2a = customer_2.invoices.create!(status: 1) 

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_2a)

        transaction_2a_1 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_2 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_3 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_4 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')

        # customer_3

        customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Builder')

        invoice_3a = customer_3.invoices.create!(status: 2)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_3a)

        transaction_3a_1 = invoice_3a.transactions.create!(credit_card_number: '3456', result: 'failed')

        # customer_4 

        customer_4 = Customer.create!(first_name: 'Cindy', last_name: 'Crawford')

        invoice_4a = customer_4.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_4a)

        transaction_4a_1 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_2 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_3 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')

        # customer_5

        customer_5 = Customer.create!(first_name: 'Gigi', last_name: 'Hadid')
        invoice_5a = customer_5.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_5a)
        transaction_5a_1 = invoice_5a.transactions.create!(credit_card_number: '6789', result: 'success')

        # customer_6

        customer_6 = Customer.create!(first_name: 'Jessie', last_name: 'J')
        invoice_6a = customer_6.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)

        transaction_6a_1 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_2 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_3 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_4 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_5 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_6 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')


        # customer_7

        customer_7 = Customer.create!(first_name: 'Channing', last_name: 'Tatum')
        invoice_7a = customer_7.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)

        transaction_7a_1 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_2 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_3 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_4 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_5 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_6 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_7 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')


        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page

        within("#top-5") do 
            expect('Channing Tatum').to appear_before('Jessie J')
            expect('Jessie J').to appear_before('Anna Marie Sterling')
            expect('Anna Marie Sterling').to appear_before('Carlos Stich')
            expect('Carlos Stich').to appear_before('Cindy Crawford')
            
            expect(page).to_not have_content('Bob Builder')
            expect(page).to_not have_content('Gigi Hadid')
        end
    end

    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    it 'displays the number of successful transactions for each top customer' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1a)

        # transaction_1a_1 = Transaction.create!(credit_card_number: '1234', result: 'success', invoice_id: invoice_1a.id)

        transaction_1a_1 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_2 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_3 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_4 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1b = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1b)
        
        transaction_1b_1 = invoice_1b.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_2 

        customer_2 = Customer.create!(first_name: 'Carlos', last_name: 'Stich')

        invoice_2a = customer_2.invoices.create!(status: 1) 

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_2a)

        transaction_2a_1 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_2 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_3 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_4 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')

        # customer_3

        customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Builder')

        invoice_3a = customer_3.invoices.create!(status: 2)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_3a)

        transaction_3a_1 = invoice_3a.transactions.create!(credit_card_number: '3456', result: 'failed')

        # customer_4 

        customer_4 = Customer.create!(first_name: 'Cindy', last_name: 'Crawford')

        invoice_4a = customer_4.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_4a)

        transaction_4a_1 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_2 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_3 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')

        # customer_5

        customer_5 = Customer.create!(first_name: 'Gigi', last_name: 'Hadid')
        invoice_5a = customer_5.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_5a)
        transaction_5a_1 = invoice_5a.transactions.create!(credit_card_number: '6789', result: 'success')

        # customer_6

        customer_6 = Customer.create!(first_name: 'Jessie', last_name: 'J')
        invoice_6a = customer_6.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)

        transaction_6a_1 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_2 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_3 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_4 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_5 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_6 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')


        # customer_7

        customer_7 = Customer.create!(first_name: 'Channing', last_name: 'Tatum')
        invoice_7a = customer_7.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)

        transaction_7a_1 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_2 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_3 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_4 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_5 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_6 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_7 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')


        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page

        within("#top-5-0") do 
            expect(page).to have_content("7 purchases")
        end

        within("#top-5-1") do 
            expect(page).to have_content("6 purchases")
        end

        within("#top-5-2") do 
            expect(page).to have_content("5 purchases")
        end

        within("#top-5-3") do 
            expect(page).to have_content("4 purchases")
        end

        within("#top-5-4") do 
            expect(page).to have_content("3 purchases")
        end
    end

    # Merchant Dashboard Items Ready to Ship
    # As a merchant
    # When I visit my merchant dashboard
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page

end