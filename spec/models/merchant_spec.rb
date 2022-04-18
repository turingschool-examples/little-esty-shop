require "rails_helper"
#   it "text" do
#     merchant = create(:merchant, enabled: false)  can control attributes by adding them in here after comma
#     merchants = create_list(:merchant, 5, merchant: merchant)
#     # item1 = create(:item, merchant: merchant)  to create one instance
#     # items = create_list(:item, 5, merchant: merchant) ==> creates multiple instances relationship for item belongs_to merchant.  Automatically assigns foreign key to that merchant
#     require "pry"; binding.pry
#   end
# end
RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should allow_value([true, false]).for(:enabled) }
    it { should_not allow_value(nil).for(:enabled) }
  end

  before :each do
    @merchant = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id, enabled: "enabled"}
    @item2 = create :item, {merchant_id: @merchant.id, enabled: "disabled"}
    @item3 = create :item, {merchant_id: @merchant2.id}
    @item4 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
  end

  describe "sorting" do
    it "returns enabled items" do
      expect(@merchant.enabled_items.first).to eq(@item1)
    end

    it "returns disabled items" do
      expect(@merchant.disabled_items.first).to eq(@item2)
    end

  end
end
