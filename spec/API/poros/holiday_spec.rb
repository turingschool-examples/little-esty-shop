require 'rails_helper'
require 'httparty'
require 'json'

RSpec.describe 'Holiday' do
  it 'can return the holidays' do
    holiday = HolidayService.new
    hash = holiday.get_holidays
    expected = HolidayFacade.find_holiday.count
    expect(hash.count).to eq(expected)
  end

  it 'can return the next three holidays' do
    holidays = HolidayFacade.find_holiday[0..2]

    expect(holidays[0].name).to eq('Juneteenth')
    expect(holidays[1].name).to eq('Independence Day')
    expect(holidays[2].name).to eq('Labor Day')
  end
end
