require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#format_currency' do
    it 'formats a number as currency' do
      expect(format_currency(0)).to eq('$0.00')
      expect(format_currency(1)).to eq('$0.01')
      expect(format_currency(10)).to eq('$0.10')
      expect(format_currency(100)).to eq('$1.00')
      expect(format_currency(1000)).to eq('$10.00')
      expect(format_currency(10000)).to eq('$100.00')
      expect(format_currency(100000)).to eq('$1,000.00')
      expect(format_currency(1000000)).to eq('$10,000.00')
      expect(format_currency(10000000)).to eq('$100,000.00')
      expect(format_currency(100000000)).to eq('$1,000,000.00')
      expect(format_currency(1000000000)).to eq('$10,000,000.00')
      expect(format_currency(10000000000)).to eq('$100,000,000.00')
    end
  end
end
