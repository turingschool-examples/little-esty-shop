require 'rails_helper'
RSpec.describe NagerDateService do
  xit 'can return 3 names' do
    @nager_date_service = NagerDateService.new
    expect(@nager_date_service.holiday_names.count).to eq(3)
  end
  xit 'can return 3 dates' do
    @nager_date_service = NagerDateService.new
    expect(@nager_date_service.holiday_dates.count).to eq(3)
  end
end
