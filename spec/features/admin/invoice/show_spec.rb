require 'rails_helper'

RSpec.describe "admin invoice show page" do
  before :each do
    @customer = Customer.create!(first_name: "First1", last_name: "Last1")
    @invoice = @customer.invoices.create!(status: 1)

  end

  describe "when I visit an invoice show page as an admin" do
    it "shows the invoice information" do
      visit "admin/invoices/#{@invoice.id}"

      expect(page).to have_content("Invoice ID: #{@invoice.id}")
      expect(page).to have_content("Invoice status: #{@invoice.status}")
      expect(page).to have_content("Created at: #{@invoice.created_at.strftime('%A, %b %d, %Y')}")
    end
  end
end
