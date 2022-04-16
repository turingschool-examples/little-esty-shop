require 'rails_helper'
require 'time'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end
  describe "relationships" do
     it { should belong_to :merchant }
  end
  describe "instance methods" do
    before :each do
      @merchant_1 = Merchant.create!(name: "Bill's Solar")
      @item_1 = @merchant_1.items.create!(name: "LG Solar Pannel", description: "3rd gen", unit_price: 10000, status: 1)
      @customer_1 = Customer.create!(first_name: "Al", last_name: "Gore")
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1,created_at: Time.parse("2019.04.12"))
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2,created_at: Time.parse("2019.04.15"))
      @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 0,created_at: Time.parse("2019.04.15"))
      @invoice_4 = Invoice.create!(customer_id: @customer_1.id, status: 1,created_at: Time.parse("2019.04.13"))
      @invoice_5 = Invoice.create!(customer_id: @customer_1.id, status: 1,created_at: Time.parse("2019.04.12"))
      @invoice_item_1 = InvoiceItem.create!(unit_price: 42, status: 1, quantity:100, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = InvoiceItem.create!(unit_price: 42, status: 1, quantity: 50, item_id: @item_1.id, invoice_id: @invoice_2.id)
      @invoice_item_3 = InvoiceItem.create!(unit_price: 42, status: 1, quantity: 55, item_id: @item_1.id, invoice_id: @invoice_3.id)
      @invoice_item_4 = InvoiceItem.create!(unit_price: 42, status: 1, quantity: 75, item_id: @item_1.id, invoice_id: @invoice_4.id)
      @invoice_item_5 = InvoiceItem.create!(unit_price: 42, status: 1, quantity: 15, item_id: @item_1.id, invoice_id: @invoice_5.id)
    end

    it'#best_sales_date returns date of most ever sales' do
      expect(@item_1.best_sales_date).to eq("2019.04.12")
    end

    it "returns the most recent date if more than one date tie for max sales" do
      @invoice_item_4.update(quantity: 115)
      expect(@item_1.best_sales_date).to eq("2019.04.13")
    end

    it "returns 'no sales records available' if no sales rerecords exist" do
      @item_2 = @merchant_1.items.create!(name: "LG Solar Pannel", description: "2rd gen", unit_price: 8000, status: 1)
      expect(@item_2.best_sales_date).to eq("no sales records available")
    end
  end
end
