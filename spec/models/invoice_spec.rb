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
    expect(@invoice1.invoice_items.count).to eq(3)
    expect(@invoice1.total_revenue).to eq(78750)
  end

  it 'returns list of invoices from old to new with invoice_items that have not been shipped' do
    expect(Invoice.incomplete_invoices_by_date.length).to eq(13)
  end
end
