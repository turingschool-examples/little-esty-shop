require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka")
    @invoice_1 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_2 = @customer_1.invoices.create!(status: "in progress")
  end

  it "shows all attributes of an invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
    expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
    expect(page).to have_content("Invoice Created at: #{@invoice_1.created_at_format}")
    expect(page).to have_content("Customer Name: #{@customer_1.first_name} #{@customer_1.last_name}")
    save_and_open_page
    expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
    expect(page).to_not have_content("Invoice Status: #{@invoice_2.status}")
  end

end
