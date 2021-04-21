require 'rails_helper'

RSpec.describe 'Admin Invoice Show' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id, enabled: 0)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, status: 0)
    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 1200)
    @item2 = create(:item, merchant_id: @merchant1.id, enabled: 0)
    @invoice2 = create(:invoice, customer_id: @customer1.id, status: 0)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id,invoice_id: @invoice1.id, quantity: 2, unit_price: 73000)
  end

  describe "when I visit my admin invoices show page" do
    it 'shows me the item name, quantity, unit price, and status' do
      visit "/admin/invoices/#{@invoice1.id}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.invoice_items.first.quantity)
      expect(page).to have_content(@item1.invoice_items.first.status)
      expect(page).to have_content(@item1.unit_price)

      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item2.invoice_items.first.quantity)
      expect(page).to have_content(@item2.invoice_items.first.status)
      expect(page).to have_content(@item2.unit_price)
    end

    it 'shows me the total revenue for each invoice show page' do
      visit "/admin/invoices/#{@invoice1.id}"
      expect(page).to have_content("150800")
    end

    it 'shows me invoice id, invoice status, invoice created_at, and customer first and last name' do
      visit "/admin/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.format_time)
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
  end

  describe "you can update the merchant invoice status" do
    it 'Invoive has a select field with the current invoice selected' do
      visit "/admin/invoices/#{@invoice1.id}"
        expect(page).to have_content(@invoice1.status)
    end

    it 'I can select a new status for the Invoice and it updates on the Merchant Invoice Show Page' do
      visit "/admin/invoices/#{@invoice1.id}"

      within ".invoice_status_update" do
        select 'cancelled', from: 'Status'
        click_on('Update Invoice')
      end

      expect(current_path).to eq(admin_invoice_path(@invoice1))
      expect(page).to have_content("cancelled")
    end
  end
end
