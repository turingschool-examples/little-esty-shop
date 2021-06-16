require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @merchant1 = Merchant.create!(name: "Nike")
    @bulk_discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 40, merchant_id: @merchant1.id)
    @bulk_discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 75, merchant_id: @merchant1.id)
    @item1 = Item.create!(name: "Kobe zoom 5's", description: "Best shoe in basketball hands down!", unit_price: 12500, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Kobe zoom 7's", description: "Second best shoe in basketball hands down!", unit_price: 11500, merchant_id: @merchant1.id)
    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 25000, status: 0, invoice_id: @invoice1.id, item_id: @item1.id)

    visit "/admin/invoices/#{@invoice1.id}"
  end

  it 'can show information related to that specific invoice' do

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
  end

  it 'can list out item names, quantity, price, and status associate with that invoice' do


    within "#invoices-items-#{@item1.id}" do
      expect(current_path).to have_content("/admin/invoices/#{@invoice1.id}")
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.unit_price)
    end

    within "#invoices-invoice-items-#{@invoice_item1.id}" do
      expect(current_path).to have_content("/admin/invoices/#{@invoice1.id}")
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.status)
    end
  end

  it 'can see the total revenue of a invoice' do

    expect(page).to have_content("$50,000")
  end

  it 'can show the total discounted revenue of an invoice' do
    expect(page).to have_content(@invoice1.total_disc_rev)
  end

  it 'can click on and change the status with a select field' do

    page.select('Completed', from: 'status')
    click_button('Update Invoice Status')

    expect(page).to have_select('status', selected: 'Completed')
  end
end
