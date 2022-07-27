require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do 

  describe 'Merchant Invoices with ids and id links' do
    it "can list all invoices that include at least on of the merchant's items" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes")
			merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
			merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

			item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
			customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
			invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
			transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
		  invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)

      visit merchant_invoices_path(merchant1.id)

      within "div#merchant" do 
        expect(page).to have_content("#{merchant1.name}")
        expect(page).to have_content("My Invoices")
        expect(page).to have_content(invoice1.id)
      end

      visit merchant_invoices_path(merchant2.id)

      within "div#merchant" do 
        expect(page).to have_content("#{merchant2.name}")
        # expect(page).to have_content(inv3.id)
        expect(page).to have_content("My Invoices")
        expect(page).to_not have_content(invoice1.id)
      end
    end
  end
end