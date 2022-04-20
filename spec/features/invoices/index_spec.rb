require 'rails_helper'

describe 'merchant invoice index page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
    )
    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100,
    )
    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony",
    )
    @invoice_1 = @customer_1.invoices.create!(
      status: 1,
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2,
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0,
    )
    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1,
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1,
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0,
    )
    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price * 2,
      status: 0,
    )
    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "failed"
    )

    visit "/merchants/#{@merchant_1.id}/invoices"
  end

  it 'displays invoices including an item from the merchant', :vcr do
    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice ##{@invoice_2.id}")

    expect(page).not_to have_content("Invoice ##{@invoice_3.id}")
  end

  it 'has links to invoice show pages', :vcr do
    click_link("#{@invoice_1.id}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
  end
end
