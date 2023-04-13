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
      expect(@invoice_1.total_revenue).to eq(2600)
      expect(@invoice_2.total_revenue).to eq(2700)
    end
  end
end