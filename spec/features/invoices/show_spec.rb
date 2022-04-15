require 'rails_helper'

describe 'invoice show page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
      created_at: Date.current,
      updated_at: Date.current
    )

    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100,
      created_at: Date.current,
      updated_at: Date.current
    )

    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
      created_at: Date.current,
      updated_at: Date.current
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony",
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_1 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2020,12,12),
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "failed"
    )

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  it 'displays pertinent information' do
    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice status: completed")
    expect(page).to have_content("Invoice created at: Saturday, December 12, 2020")
    expect(page).to have_content("For customer: Malcolm Jordan")
  end

  it 'displays invoice item information' do
    within("#ii-#{@invoice_item_1.id}") do
      expect(page).to have_content("Soccer Ball")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Sold for: $320.0 each")
      expect(page).to have_content("Status: packaged")
    end
    within("#ii-#{@invoice_item_2.id}") do
      expect(page).to have_content("Cup")
      expect(page).to have_content("Quantity: 50")
      expect(page).to have_content("Sold for: $100.0 each")
      expect(page).to have_content("Status: packaged")
    end
    within ("#invoice_items") do
      expect(page).not_to have_content("Beer")
      expect(page).not_to have_content("Quantity: 2")
      expect(page).not_to have_content("Sold for: $1.0 each")
    end
  end

  it "displays the total revenue to be made by all items on the invoice" do
    within("#total_revenue") do
      expect(page).to have_content("Total: $5320.0")
    end
  end

  it 'displays a form to switch item status' do
    # As a merchant
    # When I visit my merchant invoice show page
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated
  end
end
