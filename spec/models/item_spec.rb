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
    # April 15 and 12 tie, so it should return the 15th as the most recent date
    it '#best_sales_date returns date of most ever sales' do
      merchant_1 = Merchant.create!(name: "Bill's Solar")
      item_1 = Item.create!(name: "LG Solar Pannel", description: "3rd gen", unit_price: 10000, status: 1)
      customer_1 = Customer.create!(first_name: "Al", last_name: "Gore")
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1,created_at: Time.parse("2019.04.12"))
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2,created_at: Time.parse("2019.04.15"))
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 0,created_at: Time.parse("2019.04.15"))
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 1,created_at: Time.parse("2019.04.13"))
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 1,created_at: Time.parse("2019.04.12"))
      invoice_item_1 = InvoiceItem.create!(unit_price: 42, status: 1, quantity, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(unit_price: 42, status: 1, quantity, item_id: item_1.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(unit_price: 42, status: 1, quantity, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(unit_price: 42, status: 1, quantity, item_id: item_1.id, invoice_id: invoice_4.id)
      invoice_item_5 = InvoiceItem.create!(unit_price: 42, status: 1, quantity, item_id: item_1.id, invoice_id: invoice_5.id)

      expect(item_1.best_sales_date).to eq("April 15, 2019")
    end
  end
end
