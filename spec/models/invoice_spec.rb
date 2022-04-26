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

    it "Shows discounted revenue for the selected invoice" do
      merchants = create_list(:merchant, 3)
      items1 = create_list(:item, 3, merchant: merchants[0])
      items2 = create_list(:item, 2, merchant: merchants[1])
      customers = create_list(:customer, 2)
  
      invoices1 = create_list(:invoice, 2, customer: customers[0])
      invoice_item1 = create(:invoice_item, invoice: invoices1[0], item: items1[0])
      invoice_item3 = create(:invoice_item, invoice: invoices1[1], item: items1[1])
      invoice_item2 = create(:invoice_item, invoice: invoices1[0], item: items1[2])
  
      invoices2 = create_list(:invoice, 2, customer: customers[1])
      invoice_item6 = create(:invoice_item, invoice: invoices2[0], item: items2[0])
      invoice_item4 = create(:invoice_item, invoice: invoices2[1], item: items2[1])
  
      bulk_discounts = create_list(:bulk_discount, 3, merchant: merchants[0])
  
      expected = ((invoice_item1.quantity * invoice_item1.unit_price) * invoice_item1.bulk_discount) + ((invoice_item2.quantity * invoice_item2.unit_price) * invoice_item2.bulk_discount)
      expect(invoices1[0].discounted_revenue).to eq(expected.to_f)
    end
  end
end
