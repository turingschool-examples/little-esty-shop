require "rails_helper"


RSpec.describe(Merchant, type: :model) do
  let(:merchant) { Merchant.new(    name: "David Marks") }

  it("is an instance of merchant") do
    expect(merchant).to(be_instance_of(Merchant))
  end

  describe("relationships") do
    it { should(have_many(:items)) }

    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }

  end

  describe("validations") do
    it { should(validate_presence_of(:name)) }
  end

  describe("model method") do
    it("ready to ship ") do
      merchant1 = Merchant.create!(      name: "Bob")
      customer1 = Customer.create!(      first_name: "cx first name",       last_name: "cx last name")
      invoice1 = customer1.invoices.create!(      status: 1,       created_at: "2012-03-25 09:53:09")
      item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
      invoice_item1 = InvoiceItem.create!(      item_id: item1.id,       invoice_id: invoice1.id,       unit_price: item1.unit_price,       quantity: 2,       status: 0)
      expect(merchant1.ready_to_ship).to(eq([item1]))
    end
  end
end
