require "rails_helper"

RSpec.describe HolidaySearch do
  it 'exists' do
    holidays = HolidaySearch.new
    expect(holidays).to be_a(HolidaySearch)
  end

  describe '#next_three_holidays' do
    it 'will return the next three holidays as Holiday objects' do
      holidays = HolidaySearch.new

      expect(holidays.next_three_holidays.count).to eq(3)
      expect(holidays.next_three_holidays.first).to be_a(Holiday)
      expect(holidays.next_three_holidays.second).to be_a(Holiday)
      expect(holidays.next_three_holidays.third).to be_a(Holiday)
    end
  end
end