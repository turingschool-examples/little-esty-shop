require 'rails_helper'

RSpec.describe ApiSearch do
  before :each do
    @api_info = ApiSearch.instance
  end

  it "it exists" do
    expect(@api_info).to be_a(ApiSearch)
  end

  it "finds repo name" do
    expect(@api_info.repo_name).to eq("little-esty-shop")
  end

  it "can access cached data" do
    expect(@api_info.repo_name).to eq(@api_info.repo_name) #this makes one request and then draws upon cached data.
  end

  it "determines validity of data" do
    @api_info.instance_variable_set(:@retrieved_time, DateTime.new(2001,2,3,4,0,0))
    expect(@api_info.send(:data_expired?)).to eq(true) #if the last request was in 2001, it is expired
    @api_info.instance_variable_set(:@retrieved_time, DateTime.now)
    expect(@api_info.send(:data_expired?)).to eq(false)
  end

end
