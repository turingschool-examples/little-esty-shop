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
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1, status: 1)
      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer: customer_1, created_at: Time.parse("2019.04.12"))
      invoice_2 = create(:invoice, customer: customer_1, created_at: Time.parse("2019.04.15"))
      invoice_3 = create(:invoice, customer: customer_1, created_at: Time.parse("2019.04.15"))
      invoice_4 = create(:invoice, customer: customer_1, created_at: Time.parse("2019.04.13"))
      invoice_5 = create(:invoice, customer: customer_1, created_at: Time.parse("2019.04.12"))
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3)
      invoice_item_4 = create(:invoice_item, item: item_1, invoice: invoice_4)
      invoice_item_5 = create(:invoice_item, item: item_1, invoice: invoice_5)

      expect(item_1.best_sales_date).to eq("April 15, 2019")
    end
  end
end
