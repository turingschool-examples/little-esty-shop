require "rails_helper"

RSpec.describe "admin index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel")
    @merchant_2 = Merchant.create!(name: "D.C.")
    @merchant_3 = Merchant.create!(name: "Darkhorse")
    @merchant_4 = Merchant.create!(name: "Image")
    
    visit "/admin/merchants"
  end

 it "each name links to an merchants' show page" do
   
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link(@merchant_3.name)
    expect(page).to have_link(@merchant_4.name)
    save_and_open_page
    click_on "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    #expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
    
  end

end