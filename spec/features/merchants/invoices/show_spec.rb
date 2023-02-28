require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe "Merchant's Invoice's Show" do

    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
    let!(:invoice1) { Invoice.create!(status: 0, customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(status: 2, customer_id: this_gai_ovah_hea.id) } 

    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }
    let!(:arugula) { bob.items.create!(name: "Arugula", description: "This arugula", unit_price: 500) }
    let!(:tomato) { bob.items.create!(name: "Tomato", description: "This a few Tomatos", unit_price: 700) }

    before (:each) do
      @inv_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, quantity: 10, unit_price: 2655, status: 1)
      @inv_item2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id, quantity: 3, unit_price: 2210, status: 0)
      @inv_item3 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: arugula.id, quantity: 15, unit_price: 650, status: 2)
      @inv_item4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: tomato.id, quantity: 20, unit_price: 550, status: 2)
    end

    describe 'As a merchant' do
      context "When I visit my merchant's invoice's show page" do
        it 'I see information related to that invoice' do
          visit merchant_invoice_path(sam.id, invoice1.id)
          
          within 'section#inv_info' do
            expect(page).to have_content("Invoice ##{invoice1.id}")
            expect(page).to have_content("Status: #{invoice1.status}")
            expect(page).to have_content("Created on: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")
          end

          within 'section#cust_info' do
            expect(page).to have_content("#{this_gai_ovah_hea.first_name} #{this_gai_ovah_hea.last_name}")
          end
        end

        it 'I see the names of all of my items on the invoice, and their invoice item attributes' do
          visit merchant_invoice_path(sam.id, invoice1.id)

          within'section#item_info' do
            expect(page).to have_content("Items on this Invoice:")
            expect(page).to have_content("Item Name #{football.name}")
            expect(page).to have_content("Quantity #{@inv_item1.quantity}")
            expect(page).to have_content("Unit Price $#{@inv_item1.unit_price / 100}")
            expect(page).to have_field('Status', with: 'packaged')
            # expect(page).to have_content("Status #{@inv_item1.status}")

            expect(page).to have_content("Item Name #{baseball.name}")
            expect(page).to have_content("Quantity #{@inv_item2.quantity}")
            expect(page).to have_content("Unit Price $#{@inv_item2.unit_price / 100}")
            expect(page).to have_field('Status', with: 'pending')
            # expect(page).to have_content("Status #{@inv_item2.status}")
          end
        end

        it "I don't see see any information related to Items for other merchants" do
          visit merchant_invoice_path(sam.id, invoice1.id)

          within'section#item_info' do
            expect(page).to_not have_content("Item Name #{arugula.name}")
            expect(page).to_not have_content("Quantity #{@inv_item3.quantity}")
            expect(page).to_not have_content("Unit Price $#{@inv_item3.unit_price / 100}")
            expect(page).to_not have_content("Status #{@inv_item3.status}")
            expect(page).to_not have_content("Item Name #{tomato.name}")
            expect(page).to_not have_content("Quantity #{@inv_item4.quantity}")
            expect(page).to_not have_content("Unit Price $#{@inv_item4.unit_price / 100}")
            expect(page).to_not have_content("Status #{@inv_item4.status}")
          end
        end

        it 'I see the total revenue that will be generated from all of my items on the invoice' do
          visit merchant_invoice_path(sam.id, invoice1.id)
          
          within'section#inv_info' do
            expect(page).to have_content("Total Revenue: $331.80")
            expect(page).to_not have_content("Total Revenue: $55.00")
            expect(page).to_not have_content("Total Revenue: $48.00")
          end
        end

        it 'I see that each invoice item status is a select field, with the current status selected' do
          visit merchant_invoice_path(sam.id, invoice1.id)
          # save_and_open_page
          within "div#inv_item_status_update-#{football.id}" do
            expect(page).to have_field('Status', with: 'packaged')
            
            select 'pending', from: 'Status'
            expect(page).to have_field('Status', with: 'pending')

            select 'shipped', from: 'Status'
            expect(page).to have_field('Status', with: 'shipped')
            expect(page).to have_button "Update Item Status"
          end

          within "div#inv_item_status_update-#{baseball.id}" do
            expect(page).to have_field('Status', with: 'pending')
            expect(page).to have_button "Update Item Status"
          end
        end

        context "when I select a new status and click the 'Update Item Status' button" do
          it "I'm returned to the merchant invoice show page, where the item's status has been changed" do
            visit merchant_invoice_path(sam.id, invoice1.id)

            expect(@inv_item2.status).to eq('pending')
            expect(@inv_item1.status).to eq('packaged')

            within "div#inv_item_status_update-#{baseball.id}" do
              select 'packaged', from: 'Status'
              click_button "Update Item Status"
              @inv_item2.reload
            end
            
            expect(current_path).to eq(merchant_invoice_path(sam.id, invoice1.id))
            expect(@inv_item2.status).to eq('packaged')

            within "div#inv_item_status_update-#{football.id}" do
              select 'shipped', from: 'Status'
              click_button "Update Item Status"
              @inv_item1.reload
            end
            
            expect(current_path).to eq(merchant_invoice_path(sam.id, invoice1.id))
            expect(@inv_item1.status).to eq('shipped')
          end
        end
      end
    end
  end
end