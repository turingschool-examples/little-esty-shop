require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#cents_to_dollars' do
    it 'converts integer cents to dollars' do
      expect(cents_to_dollars(100)).to eq('$1.00')
      expect(cents_to_dollars(150)).to eq('$1.50')
      expect(cents_to_dollars(2057)).to eq('$20.57')
    end
  end
end