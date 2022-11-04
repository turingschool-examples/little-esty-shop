require "rails_helper"

RSpec.describe "admin merchant edit page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants/new"
  end

  it "can create new merchant" do
    expect(page).to have_content("New Admin Merchant Page")
    fill_in "name", with: "5th Teammate LLC"
    click_button "Submit"
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("5th Teammate LLC")
    expect(Merchant.last.status).to eq("disabled")
  end
end
