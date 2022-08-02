require 'rails_helper'

RSpec.describe 'Merchant Items New Page' do
  it "can create a new item" do
    merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)

    visit new_merchant_item_path(merchant)

    expect(find('form')).to have_content("Name")
    expect(find('form')).to have_content("Description")
    expect(find('form')).to have_content("Unit price")
  end 

  it "can fill in form and be redirected back to item index page" do 
    merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)

    visit new_merchant_item_path(merchant)

    fill_in "Name", with: "MacBook"
    fill_in "Description", with: "laptop"
    fill_in "Unit price", with: "900000"

    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(merchant))
    expect(page).to have_content("MacBook")
  end 
end 
