require 'rails_helper'
require 'date'

RSpec.describe 'On the Merchant Invoices Show Page' do
  describe 'When I visit /merchants/:merchant_id/invoices/:invoice_id' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Dave")
      @merchant_2 = Merchant.create!(name: "Kevin")

      @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
      @merchant_1_item_2 = @merchant_1.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 2)
      @merchant_2_item_1 = @merchant_2.items.create!(name: "A Thing", description: "Will do the thing", unit_price: 2)

      @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
      @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")

      @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1)
      @customer_2_invoice_1 = @customer_2.invoices.create!(status: 2)

      @invoice_item_1 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, status: 1)
      @invoice_item_2 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_2, quantity: 5, status: 2)
      @invoice_item_3 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_2_item_1, quantity: 8, status: 3)
      @invoice_item_4 = InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 9, status: 2)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@customer_1_invoice_1.id}"
    end
    describe 'Then I see' do
      it 'invormation related to that invoice' do
          expect(page).to have_content(@customer_1_invoice_1.id)
          expect(page).to have_content(@customer_1_invoice_1.status.capitalize)
          expect(page).to have_content(@customer_1_invoice_1.created_at.strftime("%A, %d %B %Y"))
          expect(page).to have_content(@customer_1.first_name)
          expect(page).to have_content(@customer_1.last_name)
      end

      it 'only invormation related to that invoice' do
        expect(page).to_not have_content("Created at: #{@customer_2_invoice_1.id}")
      end

      it 'all the items on this invoice and their name, quanitity, price, and invoice status' do
        within "#item-info-#{@customer_1_invoice_1.id}" do
          expect(page).to have_content(@merchant_1_item_1.name)
          expect(page).to have_content(@invoice_item_1.quantity)
          expect(page).to have_content(@merchant_1_item_1.price)
          expect(page).to have_content(@invoice_item_1.status)

          expect(page).to have_content(@merchant_1_item_2.name)
          expect(page).to have_content(@invoice_item_2.quantity)
          expect(page).to have_content(@merchant_1_item_2.price)
          expect(page).to have_content(@invoice_item_2.status)

          expect(page).to_not have_content(@merchant_2_item_1.name)
          expect(page).to_not have_content(@invoice_item_3.quantity)
          expect(page).to_not have_content(@merchant_1_item_2.price)
          expect(page).to_not have_content(@invoice_item_3.status)
        end
      end

      it 'only items for this invoice and merchant' do

      end
    end
  end
end