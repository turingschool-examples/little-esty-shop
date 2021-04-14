require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "class methods" do
    describe "#all_incomplete_invoices" do
      it "returns all invoices with a status of 'in progress'" do
        customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
        invoice1 = customer.invoices.create!(status: 0)
        invoice2 = customer.invoices.create!(status: 1)
        invoice3 = customer.invoices.create!(status: 2)
        invoice4 = customer.invoices.create!(status: 0)

        expect(Invoice.all_incomplete_invoices).to eq([invoice1, invoice4])
      end
    end
  end
end