require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_numericality_of :quantity}
    it { should validate_numericality_of :unit_price}
    it { should define_enum_for(:status).with_values(["pending", "packaged", "shipped"])}
  end

  let!(:merchant1) { create(:merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  let!(:customer1) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1) }

  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524) }

  describe "#instance methods" do
    it "#unit_price_converted shows unit price as a currency format" do
      expect(invoice_item1.unit_price_converted).to eq("$30.11")
    end
  end
end
