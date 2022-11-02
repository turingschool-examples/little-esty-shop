require 'rails_helper'

RSpec.describe "Merchant Invoice Show" do 
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
    
    InvoiceItem.create!(quantity: 1, unit_price: 5000, status: "Pending", item_id: @item1.id, invoice_id: @invoice1.id)

  end

  describe 'US-15: Merchant Item Show Page'do 
    describe 'As a merchant, when I visit my invoice show page, I see info related to that invoice' do 
      it 'I see info of (invoice id, invoice status, invoice created_at date in format (Monday, July 18, 2019), & customer first and last name' do 

        visit merchant_invoice_path(@merchant1, @invoice1)
        save_and_open_page
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice1.status)
        expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(@invoice1.customer.first_name)
        expect(page).to have_content(@invoice1.customer.last_name)
        expect(page).to_not have_content(@invoice2.customer.first_name)
        expect(page).to_not have_content(@invoice2.customer.last_name)
        
      end
    end
  end
end