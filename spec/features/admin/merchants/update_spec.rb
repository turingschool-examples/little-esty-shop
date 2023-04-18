require 'rails_helper'

RSpec.describe '/admin/merchants', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
  end

  it 'has correct fields' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    expect(page).to have_field("Name", with: "#{@merchant_1.name}")
  end

  it 'can update and redirect' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    fill_in "Name", with: "Target"

    click_on "Submit"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Target")
    within "#flash_message" do
      expect(page).to have_content("Successfully Updated")
    end
  end

  it 'has sad path' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    fill_in "Name", with: ""

    click_on "Submit"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    expect(page).to have_content("Field cannot be blank")
  end
end  