require 'rails_helper'

RSpec.describe InvoiceItem do
  before(:each) do
  end

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'class methods' do
    describe '#invoices_with_unshipped_items' do
      it 'returns the ids of all invoices with unshipped items' do
        expect(InvoiceItem.invoices_with_unshipped_items.count).to eq(843)
        expect(InvoiceItem.invoices_with_unshipped_items.first).to eq(1)
        expect(InvoiceItem.invoices_with_unshipped_items.last).to eq(900)
      end
    end
  end

  describe 'instance methods' do
  end
end
