require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "Class methods" do
    it '#find_invs_by_merchant' do
      merchant_1 = Merchant.create!(name: "Store Store")
      merchant_2 = Merchant.create!(name: "Erots")

      customer_1 = Customer.create!(first_name: "Malcolm",last_name: "Jordan")
      customer_2 = Customer.create!(first_name: "Jimmy",last_name: "Felony")

      invoice_1 = customer_1.invoices.create!(status: 1)
      invoice_2 = customer_2.invoices.create!(status: 2)

      cup = merchant_1.items.create!(name: "Cup", description: "What the **** is this thing?", unit_price: 1000)
      beer = merchant_2.items.create!(name: "Beer", description: "Happiness <3", unit_price: 100)

      invoice_item_1 = InvoiceItem.create!(item_id: cup.id, invoice_id: invoice_1.id, quantity: 1, unit_price: cup.unit_price, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: beer.id, invoice_id: invoice_2.id, quantity: 50, unit_price: beer.unit_price, status: 1)

      expect(Invoice.find_invs_by_merchant(merchant_1.id)).to eq([invoice_1])
    end
  end
end
