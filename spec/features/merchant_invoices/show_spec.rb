require 'rails_helper'

RSpec.describe "Merchant Invoice Show page" do
  before :each do
    @merchant = Merchant.create!(name: 'Brylan')
        @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
        @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
        @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
        @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: 'Wed, 01 Jan 2022 21:20:02 UTC +00:00')
        @invoice_7 = @customer_1.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-27 14:54:09 UTC"))
        @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 5, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-28 14:54:09 UTC"))

        @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
  end

  it "displays the invoice information in the show page" do
    visit merchant_invoice_path(@merchant, @invoice_1)

    within "#invoice-header-#{@invoice_1.id}" do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
    end

    within "#invoice-#{@invoice_1.id}" do
      save_and_open_page
      expect(page).to have_content("Status: completed")
      expect(page).to have_content("Created on: Saturday, January 01, 2022 ")
      expect(page).to have_content("Joey Ondricka")
    end
  end
end
