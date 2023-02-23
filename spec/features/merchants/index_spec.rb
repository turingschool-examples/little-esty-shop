require 'rails_helper'
RSpec.describe Merchant, type: :feature do 

  describe 'Merchant Dashboard' do

    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 

    let!(:crystal_vase) { bob.items.create!(name: "Crystal Vase", description: "Genuine crystal vase", unit_price: 5000) }
    let!(:cat_statue) { bob.items.create!(name: "Cat Statue", description: "Vintage cat statue", unit_price: 2500) }
    let!(:ceramic_planter) { bob.items.create!(name: "Ceramic Planter", description: "Black ceramic planter", unit_price: 2500) }

    before (:each) do 
      visit merchant_dashboard_index_path(bob.id)
    end

    describe 'As a merchant' do 
      context 'When I visit merchant dashboard' do 
# user 1
        it 'displays the name of my merchant' do
          expect(page).to have_content("Name: Bob's Beauties")
          expect(page).to have_content("Name: #{bob.name}")
        end
#user 2
        it 'displays a link to my merchant items index' do
          expect(page).to have_link('My Items')
        end
      
        it 'displays a link to my merchant invoices index' do
          expect(page).to have_link('My Invoices')
        end
      end

      context 'in the section for Items Ready to Ship' do 
 #user 4
        it 'displays a list of names of all items that have been ordered but not shipped' do

        end
        it 'displays the id of the invoice that ordered that item'

        it 'displays invoice ids as a link to my merchants invoice show page'
      end
    end
  end
end