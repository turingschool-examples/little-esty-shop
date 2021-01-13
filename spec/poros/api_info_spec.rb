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

end