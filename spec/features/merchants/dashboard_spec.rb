require 'rails_helper'

RSpec.describe 'Merchant_Dashboard' do
  describe 'US_1' do 
    it 'when I visit merchant dashboard, I see name of merchant' do 

      stephen = Merchant.create!(name: "Stephen's shop")
      kevin = Merchant.create!(name: "Kevin's shop")

      visit "/merchants/#{stephen.id}/dashboard"
      
      expect(page).to have_content(stephen.name)
      expect(page).to_not have_content(kevin.name)
  
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
          stephen = Merchant.create!(name: "Stephen's shop")
          kevin = Merchant.create!(name: "Kevin's shop")

          item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: stephen.id) 
          item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: stephen.id) 
          item3 = Item.create!(name: "Floppy Disk", description: "Insane memory storage", unit_price: 100, merchant_id: kevin.id) 

          visit "/merchants/#{stephen.id}/dashboard"
      
          expect(page).to have_link("#{stephen.name}'s Item index")
          expect(page).to have_link("#{stephen.name}'s Invoice index")
          expect(page).to_not have_content("#{kevin.name}'s Item index")
          expect(page).to_not have_content("#{kevin.name}'s Invoice index") 

      end
    end

    describe 'US 3' do
      describe 'Merchant Dashboard Statistic- Favorite customers' do
        it 'As merchant in dashboard, I see names of top 5 customers who have largests number of 
            transaction with merchant' do

            
            end
      end
    end

  end
end