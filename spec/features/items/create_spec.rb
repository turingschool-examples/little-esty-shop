require 'rails_helper'

RSpec.describe 'create merchant items' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
  end

  it 'can create an item and redirect' do

    visit "/merchants/#{@merchant_1.id}/items/new"

    fill_in "Name", with: "Sledge Hammer"
    fill_in "Description", with: "Smash"
    fill_in "Unit price", with: "6000"
    click_on "Save"

    within "#Disabled" do
      expect(page).to have_content("Sledge Hammer")
    end

    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

  end
end