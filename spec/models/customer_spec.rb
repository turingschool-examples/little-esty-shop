require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe '#top_five' do

      let!(:merchant) { create(:merchant) }
      let!(:customers) { create_list(:customer, 10) }
      let!(:item) { create(:item, merchant_id: merchant.id)}
      let!(:invoice_item) { create_list(:invoice_item, 6)}
        before(:each) do
          Transaction.last(5).map { |t| t.update!(result: 1) }
        end
      it 'returns the top 5 customers name with revenue' do
        require "pry"; binding.pry
      end
      end
    end
end
