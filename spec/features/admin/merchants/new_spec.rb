require 'rails_helper'

RSpec.describe 'Admin merchant new' do

  it "can create a new merchant" do
    visit '/admin/merchants'
    expect(page).to have_link("Create New Merchant")
    click_link "Create New Merchant"
    expect(current_path).to eq('/admin/merchants/new')
    fill_in "Name", with: "Axolotl Lederhosen"
    click_button "Submit"
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Axolotl Lederhosen")
    #need a test to make sure the default status is disabled
  end

end
