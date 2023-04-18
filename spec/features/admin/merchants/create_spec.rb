require 'rails_helper'

RSpec.describe 'create merchant' do

  it 'can create a merchant and redirect' do

    visit "/admin/merchants/new"

    fill_in "Name", with: "Donkey Kong Surplus"
   
    click_on "Save"

    within "#Disabled" do
      expect(page).to have_content("Donkey Kong Surplus")
    end
    expect(page).to have_current_path("/admin/merchants")
  end
end