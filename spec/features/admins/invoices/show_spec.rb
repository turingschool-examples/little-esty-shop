require 'rails_helper'

RSpec.describe 'Invoice Show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-24 09:54:09 UTC')

    @item_1 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'item 2', description: 'item', unit_price: 1000)
    @item_3 = @merchant_1.items.create!(name: 'item 3', description: 'item', unit_price: 1000)
    @item_4 = @merchant_1.items.create!(name: 'item 4', description: 'item', unit_price: 1000)

    @ii1 = InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 4, unit_price: 1000, status: 0)
    @ii2 = InvoiceItem.create!(invoice: @invoice_1, item: @item_2, quantity: 3, unit_price: 1000, status: 0)
    @ii3 = InvoiceItem.create!(invoice: @invoice_1, item: @item_3, quantity: 2, unit_price: 1000, status: 0)
    @ii4 = InvoiceItem.create!(invoice: @invoice_1, item: @item_4, quantity: 1, unit_price: 1000, status: 0)

    visit admin_invoice_path(@invoice_1.id)
  end

  it 'can display the attributes of a particular invoice' do

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    # expect(page).to have_content(@customer_1.first_name)
    # expect(page).to have_content(@customer_1.last_name)
    expect(page).to have_no_content(@invoice_2.id)
  end

  it 'can display all of the items on that invoice' do

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
  end

  it 'can display the attributes of each item on the invoice' do

    within(:css, "##{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@ii1.quantity)
      expect(page).to have_content(@ii1.unit_price)
      expect(page).to have_content(@ii1.status)
    end
  end

  it 'can update an invoice status' do
    select('in progress', :from => 'status').select_option

    click_on "Update Invoice Status"

    @invoice_1.reload

    expect(@invoice_1.status).to eq('in progress')
  end
end
