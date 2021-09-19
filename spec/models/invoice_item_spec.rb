require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe 'enums' do
    it { should define_enum_for(:status) }

    it 'can be packaged' do
      invoice_item = build(:invoice_item)
      expect(invoice_item.status).to eq('packaged')
    end

    it 'can be pending' do
      invoice_item = build(:invoice_item, status: 1)
      expect(invoice_item.status).to eq('pending')
    end

    it 'can be shipped' do
      invoice_item = build(:invoice_item, status: 2)
      expect(invoice_item.status).to eq('shipped')
    end
  end
end
