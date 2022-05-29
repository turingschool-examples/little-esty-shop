require "rails_helper"

RSpec.describe "merchant's invoice show page", type: :feature do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)

    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")

    @invoice_1 = @cust_1.invoices.create!(status: 1)
    @invoice_2 = @cust_1.invoices.create!(status: 1)
    @invoice_3 = @cust_1.invoices.create!(status: 1)
    @invoice_4 = @cust_2.invoices.create!(status: 1)
    @invoice_5 = @cust_2.invoices.create!(status: 1)
    @invoice_6 = @cust_2.invoices.create!(status: 1)
  end

  it "shows invoice ID, invoice status, created at time formatted and customer name" do
    visit "/merchants/#{@merch_1.id}/invoices/#{@invoice_1.id})"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at}")
    expect(page).to have_content("Debbie Twolegs")

    expect(page).to_not have_content("#{@invoice_2.id}")
    expect(page).to_not have_content("#{@invoice_2.status}")
    expect(page).to_not have_content("#{@invoice_2.created_at}")
    expect(page).to_not have_content("Tommy Doubleleg")
  end
end
