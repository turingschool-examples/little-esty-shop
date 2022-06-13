require 'rails_helper'

RSpec.describe HolidayService do
  it "can recieve data from JSON" do
    data = HolidayService.holidays

    expect(data).to be_an Array

  end
end
