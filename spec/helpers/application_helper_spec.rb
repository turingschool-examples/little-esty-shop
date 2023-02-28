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

  describe 'display_and_order(statuses, default_status)' do
    
    it 'returns a list of all statuses with the default status argument listed first' do
      statuses = ["cancelled", "in_progress", "completed"]
      expect(display_and_order(statuses, "completed")).to eq(["completed", "cancelled", "in_progress"])
      expect(display_and_order(statuses, "in_progress")).to eq(["in_progress", "cancelled", "completed"])
    end
  end
end