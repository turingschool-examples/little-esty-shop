require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :unit_price }
  end

  describe '#unit_price_to_dollars' do
    it 'converts unit price to dollars' do
      item1 = Item.find(1)
      item2 = Item.find(2)
      item3 = Item.find(3)

      expect(item1.unit_price_to_dollars).to eq(751.07)
      expect(item2.unit_price_to_dollars).to eq(670.76)
      expect(item3.unit_price_to_dollars).to eq(323.01)
    end
  end

  describe '#dollars_to_unit_price' do
    it 'converts dollars to unit_price' do
      expect(Item.dollars_to_unit_price(100.99)).to eq(10_099)
      expect(Item.dollars_to_unit_price(0)).to eq(0)
      expect(Item.dollars_to_unit_price('99.99')).to eq(9999)
    end
  end

  describe '#best_day_by_revenue' do
    it 'returns the day an item had the most successful transactions and revenue' do
      item = Item.find(12)

      item2 = Item.create!(name: 'FlexTape', description: 'Seals things', unit_price: 2499, merchant_id: 1)
      customer = Customer.find(1)
      invoice = customer.invoices.create!(status: 2)
      transaction = invoice.transactions.create!(credit_card_number: 1_234_567_890_987, result: 'success')
      InvoiceItem.create!(invoice_id: invoice.id, item_id: item2.id, quantity: 12, unit_price: 2499, status: 2)

      item3 = Item.create!(name: 'FlexSeal', description: 'Seals things', unit_price: 2799, merchant_id: 1)

      expect(item.best_day_by_revenue).to eq('3/14/2012')
      expect(item2.best_day_by_revenue).to eq(Time.now.strftime('%-m/%-d/%Y'))
    end
  end
end
