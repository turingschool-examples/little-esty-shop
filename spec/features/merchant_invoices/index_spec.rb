require 'rails_helper'


RSpec.describe "Merchant Invoice page" do
  before :each do
    @merchant = Merchant.create!(name: 'Brylan')
        @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
        @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
        @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
        @invoice_1 = @customer_1.invoices.create!(status: 'completed')
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

  it 'can display all of the invoices that include at least one of my merchants items, and their ids' do
    visit merchant_invoices_path(@merchant.id)

    within "#heading" do
      expect(page).to have_content("My Invoices")
    end

    within "#invoice-#{@invoice_1.id}" do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
    end

    within "#invoice-#{@invoice_7.id}" do
      expect(page).to have_content("Invoice ##{@invoice_7.id}")
    end
  end

  it 'Links each invoice with its specific show page' do
    visit merchant_invoices_path(@merchant.id)
    save_and_open_page
    click_on "Invoice ##{@invoice_1.id}"

    expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
  end

  it 'Links each invoice with its specific show page' do
    visit merchant_invoices_path(@merchant.id)
    save_and_open_page
    click_on "Invoice ##{@invoice_7.id}"

    expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_7))
  end
end
