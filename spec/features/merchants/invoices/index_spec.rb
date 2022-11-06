require 'rails_helper'
require 'date'

RSpec.describe 'On the Merchant Invoices Index Page' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dave")
    @merchant_2 = Merchant.create!(name: "Kevin")

    @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
    @merchant_2_item_1 = @merchant_2.items.create!(name: "Merchant 2 Item", description: "...", unit_price: 2)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
    @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "David", last_name: "Hill")

    @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1)
    @customer_1_invoice_2 = @customer_1.invoices.create!(status: 1)
    @customer_2_invoice_1 = @customer_2.invoices.create!(status: 1)
    @customer_3_invoice_1 = @customer_3.invoices.create!(status: 1)

    InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, status: 2)
    InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_1_item_1, quantity: 1, status: 2)
    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, status: 2)
    InvoiceItem.create!(invoice: @customer_3_invoice_1, item: @merchant_2_item_1, quantity: 1, status: 2)

    visit "/merchants/#{@merchant_1.id}/invoices"
  end
  describe 'When I visit /merchants/:merchant_id/invoices' do
    describe 'Then I see' do
      it 'all the invoices and invoice_ids that include at least one of the merchants items' do
        expect(page).to have_content("Invoice # #{@customer_1_invoice_1.id}")
        expect(page).to have_content("Invoice # #{@customer_1_invoice_2.id}")
        expect(page).to have_content("Invoice # #{@customer_2_invoice_1.id}")
        expect(page).to_not have_content("Invoice # #{@customer_3_invoice_1.id}")
      end

      it 'each invoice_id is a link to that invoice show page' do
        visit "/merchants/#{@merchant_1.id}/invoices"

        click_link "#{@customer_1_invoice_1.id}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@customer_1_invoice_1.id}")
      end
    end
  end
end