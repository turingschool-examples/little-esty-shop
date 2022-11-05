require 'rails_helper' 

RSpec.describe 'Admin Invoice Show Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: "Kevin's Illegal goods")
    @merchant2 = Merchant.create!(name: "Denver PC parts")

    @customer1 = Customer.create!(first_name: "Sean", last_name: "Culliton")
    @customer2 = Customer.create!(first_name: "Sergio", last_name: "Azcona")
    @customer3 = Customer.create!(first_name: "Emily", last_name: "Port")

    @item1 = @merchant1.items.create!(name: "Funny Brick of Powder", description: "White Powder with Gasoline Smell", unit_price: 5000)
    @item2 = @merchant1.items.create!(name: "T-Rex", description: "Skull of a Dinosaur", unit_price: 100000)
    @item3 = @merchant2.items.create!(name: "UFO Board", description: "Out of this world MotherBoard", unit_price: 400)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2022-11-01 11:00:00 UTC")
    
    @invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: 5000, status: 0, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item2 =InvoiceItem.create!(quantity: 2, unit_price: 5000, status: 1, item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 54, unit_price: 8000, status: 2, item_id: @item3.id, invoice_id: @invoice2.id)

  end

  describe 'as an admin when i visit admin invoice show page' do 
    it 'i see invoice id, status, crated at date, and customer first and last name' do 
      visit admin_invoice_path(@invoice1)
      # require 'pry'; binding.pry
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content("Invoice Status: in progress")
      expect(page).to have_content("Invoice Created on: Tuesday, November 01, 2022")
      expect(page).to have_content("Invoice's Customer Name: Sergio Azcona")
      expect(page).to_not have_content("Invoice ID: #{@invoice2.id}")
      expect(page).to_not have_content("Invoice Customer Name: Emily Port")

    end

    it 'i see all of items on invoice and item name, quantity, price, and invoice item status' do 
      visit admin_invoice_path(@invoice1)
      expect(page).to have_content("Item: #{@item1.name}")

    end
  end
end