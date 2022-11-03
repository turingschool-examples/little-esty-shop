require "rails_helper"

RSpec.describe "admin show page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel")
    @merchant_2 = Merchant.create!(name: "D.C.")
    @merchant_3 = Merchant.create!(name: "Darkhorse")
    @merchant_4 = Merchant.create!(name: "Image")
    
    visit "/admin/merchants"
  end

  it "shows name of each merchant" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    
  end
end