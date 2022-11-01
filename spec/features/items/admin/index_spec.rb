require 'rails_helper'

RSpec.describe 'Admin Index' do
  before :each do 

  end
  it "has a header" do 
    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end
end