require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should have_many(:transactions)}
    it {should belong_to(:customer)}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'instance methods' do
    before(:each) do
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1)
    end

    describe '#format_date_long' do
      it 'returns the date in specified story format Wednesday, January 04, 2023' do
        expected = "Wednesday, January 04, 2023"
        
        expect("2023-01-04 16:29:30 +0000".to_datetime.to_formatted_s(:admin_invoice_date)).to eq(expected)
      end
    end
  end
end