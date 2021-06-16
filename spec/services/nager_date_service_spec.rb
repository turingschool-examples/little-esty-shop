require 'rails_helper'
RSpec.describe NagerDateService do

  describe 'instance methods' do
    describe '.holiday_names' do
      it 'can return the names of the next 3 holidays' do
        @nager_date_service = NagerDateService.new

        expect(@nager_date_service.holiday_names.count).to eq(3)
        expect(@nager_date_service.holiday_names).to eq(["Independence Day", "Labour Day", "Columbus Day"])
      end
    end
    describe '.holiday_dates' do
      it 'can return the dates of the next 3 holidays' do
        @nager_date_service = NagerDateService.new

        expect(@nager_date_service.holiday_dates.count).to eq(3)
        expect(@nager_date_service.holiday_dates).to eq(["2021-07-05", "2021-09-06", "2021-10-11"])
      end
    end
    describe '.holidays' do
      it 'can return a hash of those 3 holidays with the values as an array of name and date' do
        @nager_date_service = NagerDateService.new

        expect(@nager_date_service.holidays).to eq({holiday_1: ["Independence Day", "2021-07-05"], holiday_2: ["Labour Day", "2021-09-06"], holiday_3: ["Columbus Day", "2021-10-11"]})
      end
    end
  end
end
