require 'rails_helper'
# rspec spec/models/invoice_spec.rb
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    let(:invoice) { create :invoice }
    let(:status) { ['in progress', 'completed', 'cancelled'] }

    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }

    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }

    it { should have_many(:merchant_invoices) }
    it { should have_many(:merchants).through(:merchant_invoices) }

    it 'responds to relationships' do
      expect(invoice).to respond_to(:invoice_items)
      expect(invoice).to respond_to(:items)
      expect(invoice).to respond_to(:transactions)
    end
  end
end
