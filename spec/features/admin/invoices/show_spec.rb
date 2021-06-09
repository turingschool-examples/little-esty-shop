require 'rails_helper'

RSpec.describe 'Admin Invoice Show' do
  describe 'admin invoice show page' do
    before(:each) do
      @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
      @invoice_1 = @customer_1.invoices.create!(status: 0)
      @invoice_2 = @customer_1.invoices.create!(status: 1)
      @invoice_3 = @customer_1.invoices.create!(status: 1)
      @invoice_4 = @customer_1.invoices.create!(status: 2)
      @invoice_5 = @customer_1.invoices.create!(status: 0)

      @merchant_1 = Merchant.create!(name: 'Roald')
      @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 39434)
      @item_2 = @merchant_1.items.create!(name: 'Lays', description: 'Deliciousio', unit_price: 8356)
      @item_3 = @merchant_1.items.create!(name: 'Cadlee', description: 'Perfecto', unit_price: 9064)

      InvoiceItem.create!(invoice: @invoice_1, item: @item_1, status: 1, quantity: 200, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_1, item: @item_2, status: 1, quantity: 295, unit_price: 8356)
      InvoiceItem.create!(invoice: @invoice_1, item: @item_3, status: 2, quantity: 382, unit_price: 9064)
      InvoiceItem.create!(invoice: @invoice_4, item: @item_1, status: 2, quantity: 130, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_5, item: @item_1, status: 1, quantity: 97, unit_price: 39434)
    end

    it 'displays invoice id and attributes including customer name' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
    end

    it 'displays invoice items info' do
      visit "/admin/invoices/#{@invoice_1.id}"

      @check_first_invoice_item = InvoiceItem.find_invoice_items(@invoice_1).first
      within("#id-#{@check_first_invoice_item.id}") do
        expect(page).to have_content(@check_first_invoice_item.name)
        expect(page).to have_content(@check_first_invoice_item.quantity)
        expect(page).to have_content(@check_first_invoice_item.convert_to_dollar)
        expect(page).to have_content(@check_first_invoice_item.status)
      end

      @check_second_invoice_item = InvoiceItem.find_invoice_items(@invoice_1)[0]

      within("#id-#{@check_second_invoice_item.id}") do
        expect(page).to have_content(@check_second_invoice_item.name)
        expect(page).to have_content(@check_second_invoice_item.quantity)
        expect(page).to have_content(@check_second_invoice_item.convert_to_dollar)
        expect(page).to have_content(@check_second_invoice_item.status)
      end
    end

    it 'displays total revenue of a specific invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"
      expected = (Invoice.expected_invoice_revenue(@invoice_1)[0].invoice_revenue.to_f / 100).to_s

      expect(page).to have_content(expected.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,"))
    end

    it 'displays a select field or button' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_button('Update Invoice Status')
      expect(@invoice_1.status).to eq('in progress')
    end

    it 'updates status after selection' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content('in progress')
      page.select('completed', from: :status)
      click_button('Update Invoice Status')
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_content('completed')
      @invoice_1.reload
      expect(@invoice_1.status).to eq('completed')
    end
  end
end
