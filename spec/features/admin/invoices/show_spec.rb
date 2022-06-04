require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }

  let!(:invoice1) { customer1.invoices.create!(status: 1, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer2.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }

  it "displays information related to the invoice" do
    visit admin_invoice_path(invoice1)

    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created at: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{invoice2.id}")
    expect(page).to_not have_content("Status: Completed")

    within ".customer" do
      expect(page).to have_content("Customer Name: Leanne Braun")
      expect(page).to_not have_content("Tony Bologna")
    end
  end
end
