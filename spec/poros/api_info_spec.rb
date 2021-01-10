require 'rails_helper'

RSpec.describe ApiInfo do
  it "it exists" do 
    api_info = ApiInfo.new
    expect(api_info).to be_a(ApiInfo)
  end
end