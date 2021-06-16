require 'rails_helper'
RSpec.describe NagerDateService do

  describe 'instance methods' do

    before(:each) do
      @nager_date_service = NagerDateService.new
      @mock_response = [{:date=>"2021-07-05",
      :localName=>"Independence Day",
      :name=>"Independence Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :type=>"Public"},
     {:date=>"2021-09-06",
      :localName=>"Labor Day",
      :name=>"Labour Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :type=>"Public"},
     {:date=>"2021-10-11",
      :localName=>"Columbus Day",
      :name=>"Columbus Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>false,
      :counties=>
       ["US-AL",
        "US-AZ",
        "US-CO",
        "US-CT",
        "US-DC",
        "US-GA",
        "US-ID",
        "US-IL",
        "US-IN",
        "US-IA",
        "US-KS",
        "US-KY",
        "US-LA",
        "US-ME",
        "US-MD",
        "US-MA",
        "US-MS",
        "US-MO",
        "US-MT",
        "US-NE",
        "US-NH",
        "US-NJ",
        "US-NM",
        "US-NY",
        "US-NC",
        "US-OH",
        "US-OK",
        "US-PA",
        "US-RI",
        "US-SC",
        "US-TN",
        "US-UT",
        "US-VA",
        "US-WV"],
      :launchYear=>nil,
      :type=>"Public"},
     {:date=>"2021-11-11",
      :localName=>"Veterans Day",
      :name=>"Veterans Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :type=>"Public"},
     {:date=>"2021-11-25",
      :localName=>"Thanksgiving Day",
      :name=>"Thanksgiving Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>1863,
      :type=>"Public"},
     {:date=>"2021-12-24",
       :localName=>"Christmas Day",
       :name=>"Christmas Day",
       :countryCode=>"US",
       :fixed=>false,
       :global=>true,
       :counties=>nil,
       :launchYear=>nil,
       :type=>"Public"},
      {:date=>"2021-12-31",
       :localName=>"New Year's Day",
       :name=>"New Year's Day",
       :countryCode=>"US",
       :fixed=>false,
       :global=>true,
       :counties=>nil,
       :launchYear=>nil,
       :type=>"Public"},
      {:date=>"2022-01-17",
       :localName=>"Martin Luther King, Jr. Day",
       :name=>"Martin Luther King, Jr. Day",
       :countryCode=>"US",
       :fixed=>false,
       :global=>true,
       :counties=>nil,
       :launchYear=>nil,
       :type=>"Public"},
      {:date=>"2022-02-21",
       :localName=>"Presidents Day",
       :name=>"Washington's Birthday",
       :countryCode=>"US",
       :fixed=>false,
       :global=>true,
       :counties=>nil,
       :launchYear=>nil,
       :type=>"Public"},
      {:date=>"2022-05-30",
       :localName=>"Memorial Day",
       :name=>"Memorial Day",
       :countryCode=>"US",
       :fixed=>false,
       :global=>true,
       :counties=>nil,
       :launchYear=>nil,
       :type=>"Public"}]
      allow(Faraday).to receive(:get).and_return(Faraday::Response.new)
      allow(JSON).to receive(:parse).and_return(@mock_response)
    end
    describe '.holiday_names' do
      it 'can return the names of the next 3 holidays' do
        expect(@nager_date_service.holiday_names.count).to eq(3)
        expect(@nager_date_service.holiday_names).to eq(["Independence Day", "Labour Day", "Columbus Day"])
      end
    end
    describe '.holiday_dates' do
      it 'can return the dates of the next 3 holidays' do
        expect(@nager_date_service.holiday_dates.count).to eq(3)
        expect(@nager_date_service.holiday_dates).to eq(["2021-07-05", "2021-09-06", "2021-10-11"])
      end
    end
    describe '.holidays' do
      it 'can return a hash of those 3 holidays with the values as an array of name and date' do
        expect(@nager_date_service.holidays).to eq({holiday_1: ["Independence Day", "2021-07-05"], holiday_2: ["Labour Day", "2021-09-06"], holiday_3: ["Columbus Day", "2021-10-11"]})
      end
    end
  end
end
