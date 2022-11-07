require 'rails_helper'

RSpec.describe 'admin/invoices/invoice.id' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')

    @merchant = Merchant.create!(name: 'Test')

    @item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'item2', description: 'desc2', unit_price: 12, merchant_id: @merchant.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: Time.parse('22.10.12'))

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 11, unit_price: 12, status: 1)

    @transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
  end
  describe 'invoice show, has invoice info, invoice items info, and total revenue' do
    it 'shows related information to a specific invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Id: #{@invoice_1.id}")
      expect(page).to have_content('Status: completed')
      expect(page).to have_content('Created at: Wednesday, October 12, 2022')
      expect(page).to have_content('Customer Name: Eli Fuchsman')
    end

    it 'shows all items on the invoice including item name, quantity, price, status' do
      visit "/admin/invoices/#{@invoice_1.id}"
      # within("#invoice_item-#{invoice}")
      expect(page).to have_content('Invoice Items:')
      expect(page).to have_content('Item Name: item1')
      expect(page).to have_content('Unit Price: 10')
      expect(page).to have_content('Quantity: 9')
      expect(page).to have_content('Status: packaged')

      expect(page).to have_content('Item Name: item2')
      expect(page).to have_content('Unit Price: 12')
      expect(page).to have_content('Quantity: 11')
      expect(page).to have_content('Status: packaged')
    end
    #   When I visit an admin invoice show page
    # Then I see the total revenue that will be generated from this invoice
    it 'i see the total revenue that will be generated from this invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content('Total Revenue of All Items: 222')
    end

    it 'can update invoice status from a select field' do
      visit "/admin/invoices/#{@invoice_1.id}"
      choose(:status, option: 'in progress')
      click_on 'Update Invoice Status'
      expect(page).to have_content('Status: in progress')
    end
  end
end
