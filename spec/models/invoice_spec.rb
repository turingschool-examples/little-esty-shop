require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    context 'status' do
      it { should validate_presence_of(:status) }
      it { should define_enum_for(:status).with_values([:in_progress, :completed, :cancelled]) }
    end
  end

  it 'calculates invoice total revenue' do
    invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 50, unit_price: @item2.unit_price, status: 'shipped')
    invoice_item3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 25, unit_price: @item3.unit_price, status: 'shipped')

    expect(@invoice1.invoice_items.count).to eq(3)
    expect(@invoice1.total_revenue).to eq(87500)
  end
end
