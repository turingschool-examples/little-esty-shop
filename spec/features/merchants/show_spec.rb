require 'rails_helper' 

RSpec.describe 'Merchants Invoice show Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')


    @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')
 
    @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
   
    @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant1.id)

    @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
   
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)
  end

  it 'is on the correct page' do 
    expect(current_path).to eq(merchant_invoice_path(@merchant1.id, @invoice1.id))
  end

  it 'displays invoice attributes' do 
    expect(page).to have_content("Invoice ID: #{@invoice1.id}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Date: #{@invoice1.format_date(@invoice1.created_at)}")
    expect(page).to have_content("#{@invoice1.customer.first_name}")
    expect(page).to have_content("#{@invoice1.customer.last_name}")
  end 
end 