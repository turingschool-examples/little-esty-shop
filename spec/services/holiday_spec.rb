require 'rails_helper'

RSpec.describe HolidayService do
  describe 'holidays' do
    let(:holiday_response) { HolidayService.holidays_data }

    it 'returns the names of next 3 holidays' do
      expect(holiday_response).to be_kind_of(Array)
      expect(holiday_response[0]).to have_key(:name)
      expect(holiday_response[0]).to have_key(:date)
    end
  end
end