require 'rails_helper'

RSpec.describe Invoice do
  before(:each) do
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    describe '#filter_by_unshipped_order_by_age' do
      it 'returns all invoices with unshipped items sorted by creation date' do
        expect(Invoice.filter_by_unshipped_order_by_age.count("distinct invoices.id")).to eq(843)
        expect(Invoice.filter_by_unshipped_order_by_age.first.id).to eq(112)
        expect(Invoice.filter_by_unshipped_order_by_age.last.id).to eq(390)
      end
    end
  end

  describe 'instance methods' do
  end
end
