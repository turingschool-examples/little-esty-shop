require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
before(:each) do 
  @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
  @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

  @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12)
  @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11)
  @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13)
  @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14)
  @item_5 = @merchant2.items.create(name: "Water", description: "see item 1, merchant 1", unit_price: 15)

  @customer_1 = Customer.create(first_name: "Steve", last_name: "Stevinson")
  @customer_2 = Customer.create(first_name: "Steve", last_name: "Stevinson")

  @invoice_1 = @customer_1.invoices.create(status: 0)
  @invoice_2 = @customer_1.invoices.create(status: 0)
  @invoice_3 = @customer_1.invoices.create(status: 0)
  # InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)

end 

  describe "as an admin" do 
    describe "visit admin show page" do 

      it "shows the invoice status is a select field (drop down) with the various enum statuses as the options" do   
        visit "/admin/invoices/#{@invoice_1.id}"

        expect(page).to have_selector("select[name='invoice_status']")
        expect(page).to have_select('invoice_status', with_options: [Invoice.statuses.keys[0], Invoice.statuses.keys[1], Invoice.statuses.keys[2]])
      
      end 

      it "the select field starts out filled out to the current status of the invoice" do

        visit "/admin/invoices/#{@invoice_1.id}"

        expect(page).to have_select('invoice_status', selected: 'in progress')
      end

      it "next to the select field there is a button to 'Update Invoice Status'" do 
        visit "/admin/invoices/#{@invoice_1.id}"

        within("div#update_invoice_status") do 
          expect(page).to have_button("Update Invoice Status")
        end 
      end 
      
      it "when you select a different options from the drop down and click the update invoice status button, you return to the invoice show page and the invoice status has changed" do 

      visit "/admin/invoices/#{@invoice_1.id}"
        expect(page).to have_select('invoice_status', selected: 'in progress')

        select Invoice.statuses.keys[2], from: "invoice_status"

        click_button("Update Invoice Status")
        save_and_open_page
        expect(page).to have_select('invoice_status', selected: 'cancelled')

        expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      end

      it "shows teh invoice id, invoice status, created at, and customer first and last name" do 

        visit "/admin/invoices/#{@invoice_1.id}"
        expect(page).to have_content("Invoice ID: #{@invoice_1.id}") 
        expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
        expect(page).to have_content("Invoice Created date: #{@invoice_1.created_at}") 
        expect(page).to have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")


      end
    end
  end
end
