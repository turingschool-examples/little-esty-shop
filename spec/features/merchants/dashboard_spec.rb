require 'rails_helper'

RSpec.describe 'Merchant_Dashboard' do
  describe 'US_1' do 
    it 'when I visit merchant dashboard, I see name of merchant' do 

      steph_merchant = Merchant.create!(name: "Stephen's shop")
      kev_merchant = Merchant.create!(name: "Kevin's shop")

      visit "/merchants/#{steph_merchant.id}/dashboard"
      
      expect(page).to have_content(steph_merchant.name)
      expect(page).to_not have_content(kev_merchant.name)
  
    end
  end

    

# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
  describe 'US_2' do 
    describe 'Merchant Dashboard Links' do 
      it 'As merchant, when visiting merchant dashboard, I see links to merchant items
          index and see a link to merhcant invoice index' do 
          steph_merchant = Merchant.create!(name: "Stephen's shop")
          kev_merchant = Merchant.create!(name: "Kevin's shop")

          item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
          item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
          item3 = Item.create!(name: "Floppy Disk", description: "Insane memory storage", unit_price: 100, merchant_id: kev_merchant.id) 

          visit "/merchants/#{steph_merchant.id}/dashboard"
      
          expect(page).to have_link("#{steph_merchant.name}'s Item index")
          expect(page).to have_link("#{steph_merchant.name}'s Invoice index")
          expect(page).to_not have_content("#{kev_merchant.name}'s Item index")
          expect(page).to_not have_content("#{kev_merchant.name}'s Invoice index") 
       end 
      end
    end

    describe 'US 3' do
      describe 'Merchant Dashboard Statistic- Favorite customers' do
        it 'As merchant in dashboard, I see names of top 5 customers who have largests number of 
            transaction with merchant' do

            
           

        end
      end
    end


    #     As a merchant
    # When I visit my merchant dashboard
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page
    describe 'US 4 and 5' do 
      describe 'Merchant Dashboard Items Ready to Ship' do 
      it 'When I visit my merchant dashboard, I see section for "Items Ready to Ship" ' do 
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        visit "/merchants/#{steph_merchant.id}/dashboard"

        expect(page).to have_content("Items Ready to Ship")

      end

      it 'In "Items Ready to Ship", I see a list of names of all items that have been ordered and not yet shipped' do 
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id) 

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        
        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"
        
        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item2.name}")
        expect(page).to have_content("#{item3.name}")

        
      end

      it 'Next to each item I see the ID(thats a link) of the invoice that ordered the item' do 
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id) 

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        
        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"
        save_and_open_page
        expect(page).to have_link("#{invoice1.id}") 
        click_link("#{invoice.id}")
        expect(current_path).to eq("/merchants/#{steph_merchant.id}/invoices/#{invoice1.id}")


      end

    end
  end
end