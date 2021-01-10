require 'rails_helper'

RSpec.describe "API page" do 
  it "displays the repo name" do 
    visit admin_path
    
    within("#api-block") do 
      expect(page).to have_content("little-esty-shop")
    end
  end
end