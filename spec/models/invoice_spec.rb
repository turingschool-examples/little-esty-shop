require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }

    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }

    it { should have_many :transactions }
  end

  describe 'methods' do
    it "can return incomplete invoices" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)

      item1 = create(:item)
      item2 = create(:item)

      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, status: 0)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item1, status: 1)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item2, status: 2)

      expect(Invoice.incomplete_invoices).to eq([invoice1, invoice2])
    end
  end
end
