require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "Class Methods" do
    describe "::incomplete_item_invoices" do
      it "it returns all invoice items where status is 'pending' or 'packaged'" do
        @customer_1 = create(:customer)

        @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new)
        @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new)

        @merchant_1 = create(:merchant)

        item_1 = create(:item, merchant_id: @merchant_1.id)
        item_2 = create(:item, merchant_id: @merchant_1.id)

        invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: item_1.id, status: 0)
        invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: item_1.id, status: 1)
        invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: item_2.id, status: 2)

        expect(InvoiceItem.incomplete_item_invoices).to eq([invoice_item_1, invoice_item_2])
      end
    end
  end
end
