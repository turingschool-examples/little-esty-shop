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

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1a)
        transaction_1a = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1b = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1b)
        transaction_1b = invoice_1b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1c = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1c)
        transaction_1c = invoice_1c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1d = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1d)
        transaction_1d = invoice_1d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1e = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1e)
        transaction_1e = invoice_1e.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_2 

        customer_2 = Customer.create!(first_name: 'Carlos', last_name: 'Stich')

        invoice_2a = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2a)
        transaction_2a = invoice_2a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2b = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2b)
        transaction_2b = invoice_2b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2c = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2c)
        transaction_2c = invoice_2c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2d = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2d)
        transaction_2d = invoice_2d.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_3

        customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Builder')

        invoice_3a = customer_3.invoices.create!(status: 2)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'pending', item: item_1, invoice: invoice_3a)
        transaction_3a = invoice_3a.transactions.create!(credit_card_number: '1234', result: 'failed')

        # customer_4 

        customer_4 = Customer.create!(first_name: 'Cindy', last_name: 'Crawford')

        invoice_4a = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4a)
        transaction_4a = invoice_4a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_4b = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4b)
        transaction_4b = invoice_4b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_4c = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4c)
        transaction_4c = invoice_4c.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_5

        customer_5 = Customer.create!(first_name: 'Gigi', last_name: 'Hadid')

        invoice_5a = customer_5.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_5a)
        transaction_5a = invoice_5a.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_6

        customer_6 = Customer.create!(first_name: 'Jessie', last_name: 'J')

        invoice_6a = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)
        transaction_6a = invoice_6a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6b = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6b)
        transaction_6b = invoice_6b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6c = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6c)
        transaction_6c = invoice_6c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6d = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6d)
        transaction_6d = invoice_6d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6e = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6e)
        transaction_6e = invoice_6e.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6f = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6f)
        transaction_6f = invoice_6f.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_7

        customer_7 = Customer.create!(first_name: 'Channing', last_name: 'Tatum')

        invoice_7a = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        transaction_7a = invoice_7a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7b = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7b)
        transaction_7b = invoice_7b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7c = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7c)
        transaction_7c = invoice_7c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7d = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7d)
        transaction_7d = invoice_7d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7e = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7e)
        transaction_7e = invoice_7e.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7f = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7f)
        transaction_7f = invoice_7f.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7g = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7g)
        transaction_7g = invoice_7g.transactions.create!(credit_card_number: '1234', result: 'success')

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

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1a)
        transaction_1a = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1b = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1b)
        transaction_1b = invoice_1b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1c = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1c)
        transaction_1c = invoice_1c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1d = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1d)
        transaction_1d = invoice_1d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1e = customer_1.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1e)
        transaction_1e = invoice_1e.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_2 

        customer_2 = Customer.create!(first_name: 'Carlos', last_name: 'Stich')

        invoice_2a = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2a)
        transaction_2a = invoice_2a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2b = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2b)
        transaction_2b = invoice_2b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2c = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2c)
        transaction_2c = invoice_2c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_2d = customer_2.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2d)
        transaction_2d = invoice_2d.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_3

        customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Builder')

        invoice_3a = customer_3.invoices.create!(status: 2)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'pending', item: item_1, invoice: invoice_3a)
        transaction_3a = invoice_3a.transactions.create!(credit_card_number: '1234', result: 'failed')

        # customer_4 

        customer_4 = Customer.create!(first_name: 'Cindy', last_name: 'Crawford')

        invoice_4a = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4a)
        transaction_4a = invoice_4a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_4b = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4b)
        transaction_4b = invoice_4b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_4c = customer_4.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4c)
        transaction_4c = invoice_4c.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_5

        customer_5 = Customer.create!(first_name: 'Gigi', last_name: 'Hadid')

        invoice_5a = customer_5.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_5a)
        transaction_5a = invoice_5a.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_6

        customer_6 = Customer.create!(first_name: 'Jessie', last_name: 'J')

        invoice_6a = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)
        transaction_6a = invoice_6a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6b = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6b)
        transaction_6b = invoice_6b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6c = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6c)
        transaction_6c = invoice_6c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6d = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6d)
        transaction_6d = invoice_6d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6e = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6e)
        transaction_6e = invoice_6e.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_6f = customer_6.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6f)
        transaction_6f = invoice_6f.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_7

        customer_7 = Customer.create!(first_name: 'Channing', last_name: 'Tatum')

        invoice_7a = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        transaction_7a = invoice_7a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7b = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7b)
        transaction_7b = invoice_7b.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7c = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7c)
        transaction_7c = invoice_7c.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7d = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7d)
        transaction_7d = invoice_7d.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7e = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7e)
        transaction_7e = invoice_7e.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7f = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7f)
        transaction_7f = invoice_7f.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_7g = customer_7.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7g)
        transaction_7g = invoice_7g.transactions.create!(credit_card_number: '1234', result: 'success')

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
    it 'has a section with a list of items that have been ordered but not yet been shipped' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'packaged', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1a)

        invoice_1b = customer_1.invoices.create!(status: 0)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1b)

        visit "merchants/#{merchant_1.id}/dashboard" 

        expect(page).to have_content('Items Ready to Ship')

        expect(item_1.name).to appear_before(item_3.name)

        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)

        expect(page).to_not have_content('Turtle Stickers')
    end 

    # And next to each Item I see the id of the invoice that ordered my item
    it 'lists the invoice id next to the Item waiting to be shipped' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'packaged', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1a)

        invoice_1b = customer_1.invoices.create!(status: 0)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1b)

        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page 

        expect(page).to have_content('Items Ready to Ship')

        within("#item-0") do 
            expect(page).to have_content(invoice_1a.id)
        end

        within("#item-1") do 
            expect(page).to have_content(invoice_1a.id)
        end

        within("#item-2") do 
            expect(page).to have_content(invoice_1a.id)
        end

        within("#item-3") do 
            expect(page).to have_content(invoice_1b.id)
        end

        within("#item-4") do 
            expect(page).to have_content(invoice_1b.id)
        end
    end 

    # And each invoice id is a link to my merchant's invoice show page
    it 'has a section with a list of items that have been ordered but not yet been shipped' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'packaged', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1a)

        invoice_1b = customer_1.invoices.create!(status: 0)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1b)

        visit "merchants/#{merchant_1.id}/dashboard" 
        # save_and_open_page 

        within("#item-0") do 
            expect(page).to have_link("Invoice ##{invoice_1a.id}")
        end

        within("#item-1") do 
            expect(page).to have_link("Invoice ##{invoice_1a.id}")
        end

        within("#item-2") do 
            expect(page).to have_link("Invoice ##{invoice_1a.id}")
        end

        within("#item-3") do 
            expect(page).to have_link("Invoice ##{invoice_1b.id}")
        end

        within("#item-4") do 
            expect(page).to have_link("Invoice ##{invoice_1b.id}")

            click_link "Invoice ##{invoice_1b.id}"
            # save_and_open_page
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_1b.id}")
    end 

    # Merchant Dashboard Invoices sorted by least recent
    # As a merchant
    # When I visit my merchant dashboard
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest
    it 'displays the date the invoice was created' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'packaged', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1a)

        invoice_1b = customer_1.invoices.create!(status: 0)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1b)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1b)

        visit "merchants/#{merchant_1.id}/dashboard" 
        save_and_open_page 

        invoice_1a_date = invoice_1a.created_at.strftime("%A, %B%e, %Y")
        invoice_1b_date = invoice_1b.created_at.strftime("%A, %B%e, %Y")

        within("#item-0") do 
            expect(page).to have_content(invoice_1a_date)
        end

        within("#item-1") do 
            expect(page).to have_content(invoice_1a_date)

        end

        within("#item-2") do 
            expect(page).to have_content(invoice_1a_date)

        end

        within("#item-3") do 
            expect(page).to have_content(invoice_1b_date)

        end

        within("#item-4") do 
            expect(page).to have_content(invoice_1b_date)
        end
    end
end