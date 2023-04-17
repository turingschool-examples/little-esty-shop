require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'format_date' do
    it 'formats the date with m/d/y and no padding' do
      expect(format_date(Date.parse('2023-01-01 20:54:10 UTC'))).to eq("1/1/23")
    end
  end
end
