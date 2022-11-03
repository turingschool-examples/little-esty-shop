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
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it "has button to enable" do
    expect(page).to have_content("Disabled Merchants")
  within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "has button to disable" do
    expect(page).to have_content("Enabled Merchants")
    within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end

  within "#enabled_merchant-#{@merchant_1.id}" do
      click_on "Disable"
      expect(@merchant_1.reload.status).to eq("disabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "link to create new merchant" do
    click_link "New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end
end
