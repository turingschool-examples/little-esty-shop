require 'rails_helper'

RSpec.describe 'Merchant Invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @item_1 = @merchant.items.create!(name: "Shirt", description: "A shirt", unit_price: 4000)
    @item_2 = @merchant.items.create!(name: "Bird shirt", description: "bird shirt", unit_price: 4000)

    @customer_1 = Customer.create!(first_name: "Tony", last_name: "Gonzales")
    @invoice_1 = @customer_1.invoices.create!(status: 0)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, status: 2, unit_price: 40 )
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 4, status: 1, unit_price: 40 )


    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

  it 'shows the invoice information of that merchant' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end


  it 'returns the total revenue from all items' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
    
    expect(page).to have_content(@invoice_1.total_revenue)
  end 

  it 'displays all the items on the invoice' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    within("#Invoice-Item-#{@invoice_item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
    end
  end

  it 'has a selector for changing the status of an invoice' do
    within("#Invoice-Item-#{@invoice_item_1.id}") do
      expect(page).to have_select("invoice_item[status]", selected: 'shipped')
      find("option[value='packaged']").click
      click_on("Update Status")
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
      expect(page).to have_content("packaged")
    end
  end
end
