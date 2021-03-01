require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:customers).through(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
  end

  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe "class method" do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)

      @customer1 = create(:customer)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)
      @item4 = create(:item, merchant_id: @merchant1.id)
      @item5 = create(:item, merchant_id: @merchant1.id)
      @item6 = create(:item, merchant_id: @merchant1.id)
      @item7 = create(:item, merchant_id: @merchant2.id)

      @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC", customer_id: @customer1.id)

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 2, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
      @invoice_item6 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item6.id, status: 2, quantity: 1, unit_price: 100)
      @invoice_item7 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item7.id, status: 2, quantity: 1, unit_price: 100)
    end

    it "#total_revenue" do
      expect(@merchant1.invoice_items.total_revenue).to eq(2100)
    end
  end
end
