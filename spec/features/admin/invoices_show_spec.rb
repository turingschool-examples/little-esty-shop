require 'rails_helper'

RSpec.describe "Admin Invoices Show Page" do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @customer = create(:customer)
    @invoice = Invoice.create!(status: 0, customer_id: @customer.id)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id, quantity: 3, unit_price: 13, status: 0)
    visit "/admin/invoices/#{@invoice.id}"
  end

  it 'can see invoice id, status, created_at date, customer first and last name' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it 'can see all items and their names, quantity ordered, price items sold for, and invoice item status' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'can see total revenue from all items on invoice' do
    expect(page).to have_content(@invoice.invoice_items.total_revenue)
  end

  it 'can update item status on invoice' do
    within("#invoice-#{@invoice.id}") do
      select('completed')
      click_on('Update Invoice Status')
    end

    expect(current_path).to eq("/admin/invoices/#{@invoice.id}")

    within("#invoice-#{@invoice.id}") do
      expect(page.find("option[selected = selected]").text).to eq('completed')
      expect(page.find("option[selected = selected]").text).not_to eq('in progress')
    end
  end
end
