require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(['in progress', 'completed', 'cancelled']) }
  end

  let!(:merchant1) { create(:merchant) }
  let!(:customer1) { create(:customer) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  let!(:invoices) { create_list(:invoice, 4, customer: customer1) }

  let!(:transaction1) { create(:transaction, invoice: invoices[0], result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoices[0], unit_price: 3011, status: 2) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoices[0], unit_price: 2524, status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: item2, invoice: invoices[1], unit_price: 2524, status: 0) }
  let!(:invoice_item4) { create(:invoice_item, item: item2, invoice: invoices[2], unit_price: 2524, status: 1) }
  let!(:invoice_item5) { create(:invoice_item, item: item2, invoice: invoices[3], unit_price: 2524, status: 2) }

  describe '#instance methods' do
    it '#total_revenue returns total revenue of an invoice' do
      expect(invoices[0].total_revenue).to eq('$55.35')
    end

    it 'formats the date correctly' do
      expect(invoices[0].formatted_date).to eq('Saturday, June 04, 2022')
    end
  end

  describe '.class methods' do
    it 'returns all invoices without a shipped status' do
      expect(Invoice.not_shipped).to eq([invoices[0], invoices[1], invoices[2]])
      expect(Invoice.not_shipped).to_not eq(invoices[3])
    end
  end
end
