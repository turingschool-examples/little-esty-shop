require 'rails_helper' 

RSpec.describe 'Merchants Invoice Index Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 = Merchant.create!(name: 'Tom Holland')


    @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')
    @customer2 = Customer.create!(first_name: 'Green', last_name: 'Goblin')


    @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 2, customer_id: @customer1.id)


    @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant1.id)

    @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
    @inv_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 200, status: 1)


    visit merchant_invoices_path(@merchant1.id)
  end

  it 'is on the correct page' do 
    expect(current_path).to eq(merchant_invoices_path(@merchant1.id))
    expect(page).to have_content("Merchant Invoices")
  end

  it 'returns all invoices related to merchant' do 
    visit merchant_invoices_path(@merchant1.id)
    within("#invoices-#{@invoice1.id}") do
  
      expect(page).to have_content("Invoice: #{@invoice1.id}")
    end 
  end

  it 'returns all invoices related to merchant' do 
    visit merchant_invoices_path(@merchant1.id)
    within("#invoices-#{@invoice1.id}") do
  
      click_link "Show"

      expect(current_path).to eq(merchant_invoice_path(@merchant1.id, @invoice1.id))
    end 
  end
end 

