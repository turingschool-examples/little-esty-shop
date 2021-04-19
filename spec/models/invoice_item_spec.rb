require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe "validations" do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
  end

  describe "instance methods" do
    it "#item_name" do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1, name: "item_1_name")
      item_2 = create(:item, merchant: merchant_1, name: "item_2_name")
      item_3 = create(:item, merchant: merchant_1, name: "item_3_name")
      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_1.id)

      expect(invoice_item_1.item_name).to eq("item_1_name")
      expect(invoice_item_2.item_name).to eq("item_2_name")
      expect(invoice_item_3.item_name).to eq("item_3_name")
    end
  end
end
