require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'format_date' do
    it 'formats the date with m/d/y and no padding' do
      expect(format_date(Date.parse('2023-01-01 20:54:10 UTC'))).to eq("1/1/23")
    end
  end

  describe 'format_revenue' do
    it 'formats an amount of cents as dollars and decimals with a dollar sign' do
      expect(format_revenue(123456)).to eq("$1235")
    end
  end
end
