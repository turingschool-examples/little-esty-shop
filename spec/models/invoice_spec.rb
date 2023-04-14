require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) } 
  end
  
  describe 'enums' do
    it do
      should define_enum_for(:status).
     with_values(["in progress", "completed", "cancelled"])
    end
  end

  describe 'instance methods' do
    before :each do
      test_data
    end
    describe 'total revenue' do
      it 'returns the total revenue from all items on the invoice.' do
        expect(@invoice_4.total_revenue).to eq(3300000)
      end
    end
  end
end
