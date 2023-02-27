require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'format_price(unit_price_in_cents)' do
    
    it 'should format a price in cents (2 digits)' do
      expect(format_price(22)).to eq('$0.22')
    end

    it '3 digits' do
      expect(format_price(123)).to eq('$1.23')
    end

    it '6 digits' do
      expect(format_price(100000)).to eq('$1,000.00')

    end

    it '12 digits' do
      expect(format_price(1_000_000_000_00)).to eq('$1,000,000,000.00')
    end
  end
end