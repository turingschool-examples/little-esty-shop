require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many :transactions }
  end

  before(:each) do
    test_data
  end

  describe '#total_revenue' do
    it 'can calculate the total revenue of an invoice' do
      expect(@invoice_1.total_revenue).to eq(26.0)
      expect(@invoice_2.total_revenue).to eq(27.0)
    end
  end

  describe'::incomplete_invoices' do
    it 'can find all invoices that have items that have not yet been shipped' do
      expect(Invoice.incomplete_invoices.count).to eq(20)

      @invoice_item_1.update(status: 2)
      @invoice_item_21.update(status: 2)
      @invoice_item_41.update(status: 2)

      expect(Invoice.incomplete_invoices.count).to eq(19)
    end

    it 'can order the invoices by their creation date' do
      expect(Invoice.incomplete_invoices.first.created_at).to be < (Invoice.incomplete_invoices.last.created_at)
    end
  end
end