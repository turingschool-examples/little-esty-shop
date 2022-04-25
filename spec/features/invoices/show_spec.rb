require "rails_helper"

describe "invoice show page" do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store"
    )
    @merchant_2 = Merchant.create!(
      name: "Erots"
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000
    )
    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100
    )
    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan"
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony"
    )
    @invoice_1 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2020, 12, 12),
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0
    )
    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0
    )
    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price,
      status: 0
    )
    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "failed"
    )
    @bulk_discount_10 = @merchant_1.bulk_discounts.create!(quantity: 10, percentage: 0.10)

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  it "displays pertinent information", :vcr do
    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice status: completed")
    expect(page).to have_content("Invoice created at: Saturday, December 12, 2020")
    expect(page).to have_content("For customer: Malcolm Jordan")
  end

  it "displays invoice item information", :vcr do
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
    within("#invoice_items") do
      expect(page).not_to have_content("Beer")
      expect(page).not_to have_content("Quantity: 2")
      expect(page).not_to have_content("Sold for: $1.0 each")
    end
  end

  it "displays the total revenue to be made by all items on the invoice", :vcr do
    within("#total_revenue") do
      expect(page).to have_content("Total: $5320.0")
    end
  end

  it "displays revenue after applying discounts" do
    expect(page).to have_content("Discounted Revenue: $4788")
  end

  it "invoice item statuses are select fields", :vcr do
    within("#ii-#{@invoice_item_1.id}") do
      expect(find("form")).to have_content("pending packaged shipped")
    end
  end

  it "updates invoice item status", :vcr do
    within("#ii-#{@invoice_item_1.id}") do
      select "shipped", from: "status"
      click_button "Update"
      expect(page).to have_content("Status: shipped")
      expect(page).to_not have_content("Status: packaged")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    end
  end
end
