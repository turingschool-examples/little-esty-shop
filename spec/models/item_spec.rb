require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_numericality_of :merchant_id }
  end
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

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
