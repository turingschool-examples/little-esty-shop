require "rails_helper"

describe InvoiceItem, type: :model do
  describe "validations" do
    it {should define_enum_for(:status).with_values ["pending", "packaged", "shipped"] }
  end

  describe "relations" do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe "class methods" do 
    it "invoice_amount" do 
      invoice = FactoryBot.create(:invoice)
      ii1 = FactoryBot.create(:invoice_item, invoice_id:invoice.id, quantity: 3, unit_price: 5) #15
      ii2 = FactoryBot.create(:invoice_item, invoice_id:invoice.id, quantity: 4, unit_price: 5) #20 
      ii3 = FactoryBot.create(:invoice_item, invoice_id:invoice.id, quantity: 5, unit_price: 5) #25

      expect(invoice.invoice_items.invoice_amount).to eq(15+20+25)
    end
  end

  describe "delegates" do
    it "fine" do
      create(:invoice_item)
      expect(InvoiceItem.first.item.name).to eq(InvoiceItem.first.item_name)
    end
  end
end
