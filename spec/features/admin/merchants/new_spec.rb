require 'rails_helper'

RSpec.describe "Create Merchant form page", type: :feature do 

  it "creates a new merchant with disabled status by default" do 

    visit "/admin/merchants/new"

    fill_in :name, with: "Handmade by Hannah"
    click_button "Create Merchant"

    expect(current_path).to eq(admin_merchants_path)
    
    within(".disabled_merchants") do
      expect(page).to have_content("Handmade by Hannah | Status: disabled")
    end
    
  end


end
