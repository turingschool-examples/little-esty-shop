require 'rails_helper'

RSpec.describe InvoiceItem do
  before(:each) do

  end

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'class methods' do
    describe '.total_revenue' do
      it 'returns expected total revenue of all invoice items' do

        expect(InvoiceItem.total_revenue).to eq(60481323)
      end
    end
  end

  describe 'instance methods' do
  end
end
