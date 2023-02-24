require 'rails_helper'
RSpec.describe Merchant, type: :feature do 

  describe 'Merchant Dashboard' do
    let!(:louise) { Customer.create!(first_name: "Louise", last_name: "Belcher") }

    let!(:invoice1) { Invoice.create!(customer_id: louise.id) } 
    let!(:invoice2) { Invoice.create!(customer_id: louise.id) } 
    let!(:invoice3) { Invoice.create!(customer_id: louise.id) } 
    
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 

    let!(:coochie_copi) { bob.items.create!(name: "Coochie Copi Night Light", description: "Night Light", unit_price: 5000) }
    let!(:napkin_holder) { bob.items.create!(name: "Napkin Holder", description: "Stainless Steel Napkin Holder", unit_price: 2500) }
    let!(:window_planter) { bob.items.create!(name: "Window Planter", description: "Plastic Window Planter", unit_price: 2500) }

    before (:each) do 
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: coochie_copi.id, status: 0)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: napkin_holder.id, status: 1)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: window_planter.id, status: 2)

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

      # context 'in the section for Items Ready to Ship' do 
 #user 4
        it 'displays a list of names of all items that have been ordered but not shipped' do
    
          within "#ready_items" do 
            expect(page).to have_content("Items Ready to Ship")
            expect(page).to have_content("Coochie Copi Night Light")
            expect(page).to have_content("Napkin Holder")

            expect(page).to_not have_content("Window Planter")
          end
        end
        it 'displays the id of the invoice that ordered that item'

        it 'displays invoice ids as a link to my merchants invoice show page'
      # end
    end
  end
end