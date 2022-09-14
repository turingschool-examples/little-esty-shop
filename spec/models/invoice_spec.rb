require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through (:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end

  describe '.not_shipped_invoices' do
    it "Should return invoice id's" do
      invoice_ids = [1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 5, 5, 7]

      expect(Invoice.not_shipped_invoices.ids).to eq invoice_ids
      expect(Invoice.not_shipped_invoices.ids.count).to eq 18
    end
  end
end
