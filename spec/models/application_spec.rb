require 'rails_helper'

RSpec.describe "Application Record Model" do

  it "formats date into day/month/year format" do
    @billman = Merchant.create!(name: "Billman", created_at: "2012-03-27 14:53:59")
    expect(@billman.created_at_format).to eq("Tuesday, March 27, 2012")
  end

end
