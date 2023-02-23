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
      it "shows teh invoice id, invoice status, created at, and customer first and last name" do 

        visit "/admin/invoices/#{@invoice_1.id}"

        expect(page).to have_content("Invoice ID: #{@invoice_1.id}, Invoice Status: #{@invoice_1.status}, Invoice Created date: #{@invoice_1.created_at}, Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")


      end
    end
  end
end
