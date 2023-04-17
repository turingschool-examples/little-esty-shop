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

  describe '#format_created_at' do
    it 'formats a date as the full day name, month name, day of the month, and year' do
      expect(format_created_at(DateTime.parse('2011-01-08 20:54:10 UTC'))).to eq('Saturday, January 08, 2011')
      expect(format_created_at(DateTime.parse('2012-05-11 13:54:10 UTC'))).to eq('Friday, May 11, 2012')
      expect(format_created_at(DateTime.parse('2013-08-21 08:54:10 UTC'))).to eq('Wednesday, August 21, 2013')
      expect(format_created_at(Time.new(2019, 1, 1))).to eq('Tuesday, January 01, 2019')
    end
  end
end
