require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
  end

  describe "class methods" do
    it "#incomplete_invoices" do
      @merchant1 = create(:merchant)

      @customer1 = create(:customer)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)
      @item4 = create(:item, merchant_id: @merchant1.id)

      @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
      @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
      @invoice4 = create(:invoice, created_at: "2020-03-25 09:54:09 UTC")

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 5, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 4, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)

      expected = [@invoice3, @invoice2, @invoice1]

      expect(Invoice.incomplete_invoices).to eq(expected)
      expect(Invoice.incomplete_invoices.first).to eq(@invoice3)
      expect(Invoice.incomplete_invoices.last).to eq(@invoice1)
    end
  end
end
