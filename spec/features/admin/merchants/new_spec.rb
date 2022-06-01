require 'rails_helper'

RSpec.describe 'Admin merchant new' do

  it "can create a new merchant" do
    visit '/admin/merchants'
    expect(page).to have_link("Create New Merhcant")
    click_link "Create New Merchant"
    expect(current_path).to eq('/admin/merchant/new')
    fill_in "Name", with: "Axolotl Lederhosen"
    click_button "Submit"
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Axolotl Lederhosen")
  end

end
