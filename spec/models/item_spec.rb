require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should have_many(:transactions).through(:invoices) }

  let!(:merchant1) { create(:merchant) }
  let!(:customer1) { create(:customer) }
  let!(:item1) { create(:item, merchant_id: merchant1.id)}
  let!(:invoice1) { create(:invoice, customer_id: customer1.id) }

  before do
    InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, status: "packaged")
  end

  describe "instance methods" do
    it "#item_invoice_id" do
      expect(item1.item_invoice_id).to eq(invoice1.id)
    end

    it "#item_invoice_id" do
      expect(item1.item_invoice_id).to eq(invoice1.id)
    end
  end
end
