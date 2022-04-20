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
    @item3 = create :item, {merchant_id: @merchant.id}
    @item4 = create :item, {merchant_id: @merchant.id}
    @item5 = create :item, {merchant_id: @merchant.id}
    @item6 = create :item, {merchant_id: @merchant.id}
    @item7 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}

    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 10, status: 2}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 2}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item3.id, quantity: 1, unit_price: 25, status: 2}
    @invoice_item4 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item4.id, quantity: 1, unit_price: 4, status: 2}
    @invoice_item5 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item5.id, quantity: 1, unit_price: 3, status: 2}
    @invoice_item6 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item6.id, quantity: 1, unit_price: 2, status: 2}
    @transaction1 = create :transaction, {result: 0, invoice_id: @invoice1.id, credit_card_expiration_date: 12121212}
    #2nd invoice item for item1
    @invoice_item7 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 10, status: 2}
    #different merchant
    @invoice_item9 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item7.id, quantity: 1, unit_price: 60, status: 2}
    #cancelled invoice
    @invoice3 = create :invoice, {customer_id: @customer.id, status: 0}
    @invoice_item8 = create :invoice_item, {invoice_id: @invoice3.id, item_id: @item7.id, quantity: 1, unit_price: 60, status: 2}
    # failed transaction
    @transaction2 = create :transaction, {result: 1, invoice_id: @invoice2.id, credit_card_expiration_date: 12121212}
    @invoice_item10 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item6.id, quantity: 1, unit_price: 100, status: 2}

  end

  describe "sorting" do
    it "returns enabled items" do
      expect(@merchant.enabled_items.first).to eq(@item1)
    end

    it "returns disabled items" do
      expect(@merchant.disabled_items.first).to eq(@item2)
    end

    it "returns 5 most popular items" do
      expect(@merchant.popular_items[0].name).to eq(@item2.name)
      expect(@merchant.popular_items[1].name).to eq(@item1.name)
      expect(@merchant.popular_items[2].name).to eq(@item3.name)
      expect(@merchant.popular_items[3].name).to eq(@item4.name)
      expect(@merchant.popular_items[4].name).to eq(@item5.name)
    end

    it "returns best day" do
      expect(@merchant.popular_items[0].item_best_day).to eq(@invoice1.created_at)
    end



  end
end
