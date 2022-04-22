require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it {
      should define_enum_for(:status).with([
        "Cancelled", "In Progress", "Completed"
      ])
    }
  end

  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "methods" do
    it "Shows the total revenue for the selected invoice" do
      @merchant1 = create(:merchant)
      @items = create_list(:item, 4, merchant: @merchant1)
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @invoice1 = create(:invoice, customer: @customer1)
      @invoice2 = create(:invoice, customer: @customer2)
      @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @items.first)
      @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @items.second)
      @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @items.third)
      @invoice_item4 = create(:invoice_item, invoice: @invoice2, item: @items.last)

      expected = (@invoice_item1.quantity * @invoice_item1.unit_price) + (@invoice_item2.quantity * @invoice_item2.unit_price)

      expect(@invoice1.total_revenue).to eq(expected)
    end
  end

  it "displays incomplete invoices", :vcr do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    customer = create(:customer)
    incomplete_invoice = create(:invoice, customer: customer, status: 1)
    incomplete_invoice_item = create(:invoice_item, invoice: incomplete_invoice, item: item, status: 1)
    complete_invoice = create(:invoice, customer: customer, status: 2)
    complete_invoice_item = create(:invoice_item, invoice: complete_invoice, item: item, status: 2)
    expect(Invoice.incomplete_invoices[0]).to eq(incomplete_invoice)
    expect(Invoice.incomplete_invoices[1]).to eq(nil)
  end
end
