require 'rails_helper'

RSpec.describe "admin merchants show" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mel's Travels")
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack")
    @merchant_3 = Merchant.create!(name: "Huy's Cheese")
  end

  it 'displays the name of each merchant in the system' do
    visit "/admin/merchants"
    click_on("#{@merchant_1.name}")

    expect(current_path).to eq("/admin/merchants//#{@merchant_1.id}")
    expect(page).to have_content("#{@merchant_1.name}")
  end
end