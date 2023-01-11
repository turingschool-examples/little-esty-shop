require 'rails_helper'

RSpec.describe 'application helper' do
  describe '#price_round' do
    it "formats prices from cents to dollars"do
      expect(helper.price_round(12345)).to include('$')
      expect(helper.price_round(12345)).to eq('$123.45')
      expect(helper.price_round(123)).to eq('$1.23')
      expect(helper.price_round(12)).to eq('$0.12')
      expect(helper.price_round(1)).to eq('$0.01')
    end
  end
end