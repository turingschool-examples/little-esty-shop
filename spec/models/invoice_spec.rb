require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do

  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "#Instance Methods" do
    describe "#total_revenue" do
      it "it returns the total revenue that will be generated from all items on the invoice" do
        merchant_1 = create(:merchant)
        
        customer_1 = create(:customer)

        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_1.id)

        item_1 = create(:item, merchant_id: merchant_1.id)
        item_2 = create(:item, merchant_id: merchant_1.id)
        item_3 = create(:item, merchant_id: merchant_1.id)

        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 3, quantity: 10)
        invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, unit_price: 2, quantity: 5)
        invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_3, unit_price: 2, quantity: 9)

        expect(invoice_1.total_revenue).to eq(30)
      end
    end
  end
end
