# I am taken to a form that allows me to add merchant information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the admin merchants index page
# And I see the merchant I just created displayed
# And I see my merchant was created with a default status of disabled.
require 'rails_helper'

RSpec.describe 'New Merchant' do
  it "can create a new application and flashes a message to tell user to fill in field if its submitted while  blank" do

    visit new_admin_merchant_path

    fill_in "Name", with: "Ted"

    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Ted")

    visit new_admin_merchant_path
    
    fill_in "Name", with: nil

    click_button "Submit"

    expect(page).to have_content("Name can't be blank")
  end
end
