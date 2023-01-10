require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    load_test_data1
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe 'class methods' do
    describe '#incomplete_invoices' do
      it 'returns a list of the ids of all invoices of items that have not been shipped ordered by the created_at date' do
        expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_3, @invoice_7, @invoice_9, @invoice_14, @invoice_16,])
        expect(Invoice.incomplete_invoices.length).to eq(6)
      end
    end
  end

  describe 'instance methods' do
    it '#calculate_total_revenue' do
      expect(@invoice_1.calculate_total_revenue).to eq 20000
      expect(@invoice_2.calculate_total_revenue).to eq 800
    end
  end
end