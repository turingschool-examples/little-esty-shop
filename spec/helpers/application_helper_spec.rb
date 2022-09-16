require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '.price_convert' do
    it 'converts an integer price to a dollar value' do
      expect(price_convert(1500)).to eq("$15.00")
      expect(price_convert(1500075)).to eq("$15,000.75")
      expect(price_convert(123456789)).to eq("$1,234,567.89")
    end
  end
end