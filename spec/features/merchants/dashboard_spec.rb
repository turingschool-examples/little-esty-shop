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

        click_link "My Invoices" 

        expect(current_path).to eq "/merchants/#{merchant_1.id}/invoices" 
    end
end