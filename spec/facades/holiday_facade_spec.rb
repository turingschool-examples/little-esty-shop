require 'rails_helper'

RSpec.describe HolidayFacade do
  it "returns holidays from JSON" do
    holidays = HoldayFacade.three_holidays

    expect(holidays).to be_an Array
    expect(holidays).to be_all Holiday

  end
end
