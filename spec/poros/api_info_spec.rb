require 'rails_helper'

RSpec.describe ApiInfo do
  before :each do 
    @api_info = ApiInfo.instance
  end

  it "it exists" do 
    expect(@api_info).to be_a(ApiInfo)
  end

  it "finds repo name" do 
    expect(@api_info.repo_name).to eq("little-esty-shop")  
  end

end