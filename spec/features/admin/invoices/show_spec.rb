require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  before :each do
    @merchant1 = create(:merchant)
    @customer1 = Customer.create(first_name: "Bob", last_name: "Bobette")
    @invoice1 = Invoice.create(customer_id: @customer1.id, status: 0)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice1.id)
  end
  describe 'When I visit an admin invoice show page' do
    it 'shows me all of the items on the invoice' do
      visit "/admin/invoices/#{@invoice1.id}"
      save_and_open_page
    end
  end
end
