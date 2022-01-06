require 'rails_helper'

RSpec.describe 'merchants invoice show page' do

  before :each do
    @merchant1 = create(:merchant)
    @invoice1 = create(:invoice)
    @item1 = create(:item, merchant: @merchant1)
    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)

    @item2 = create(:item)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id)
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
  end

  it 'displays all information related to that invoice' do

    expect(page).to have_content("#{@invoice1.id}'s Information")
    expect(page).to have_content("Merchant: #{@merchant1.name}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created On: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@invoice1.customer_name}")
  end

  it 'displays the invoiced item name' do

    expect(page).to have_content(@item1.name)
  end

  it 'displays the quantity of the item ordered' do

    expect(page).to have_content("Quantity Ordered: #{@invoice_item1.quantity}")
  end

  it 'displays the price the item sold for' do

    expect(page).to have_content("Unit Price: $#{@item1.unit_price.to_f/100}")
  end

  it 'displays the invoice item status' do

    expect(page).to have_content("Status: #{@invoice_item1.status}")
  end

  it 'does not display any other merchants items information' do

    expect(page).to_not have_content(@item2.name)
  end
end
