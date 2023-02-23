require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe 'Merchant Invoices Index' do

    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
    let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    before (:each) do
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id)

      visit merchant_invoices_path(sam.id)
    end

    describe 'As a merchant' do 
      context 'When I visit my merchant invoices index page' do
        it "I should see a list of invoices include at least one of my merchant's items" do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("My Invoices")

          within 'div#invoices_list' do
            expect(page).to have_content("Invoice ##{invoice1.id}")
            expect(page).to have_content("Invoice ##{invoice2.id}")
            expect(page).to_not have_content("Invoice ##{invoice3.id}")
          end
        end

        it "I see that each invoice id is a link to that merchant's invoice's show page" do
          within 'div#invoices_list' do
            expect(page).to have_link("#{invoice1.id}")
            expect(page).to have_link("#{invoice2.id}")
            expect(page).to_not have_link("#{invoice3.id}")
          end
        end
      end
    end
  end
end