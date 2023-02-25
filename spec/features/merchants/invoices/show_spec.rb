require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe "Merchant's Invoice's Show" do

    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
    let!(:invoice1) { Invoice.create!(status: 0, customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(status: 1, customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice3) { Invoice.create!(status: 2, customer_id: this_gai_ovah_hea.id) } 

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    before (:each) do
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, quantity: 10, unit_price: 1200)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id)
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

        it '' do

        end
      end
    end
  end
end