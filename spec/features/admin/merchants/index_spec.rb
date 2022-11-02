require "rails_helper"

RSpec.describe "admin merchant index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants"
  end

  it "shows name of each merchant" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
  end

  it "each name links to show page" do
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link(@merchant_3.name)
    expect(page).to have_link(@merchant_4.name)
    expect(page).to have_link(@merchant_5.name)
    click_on "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
  end

end
