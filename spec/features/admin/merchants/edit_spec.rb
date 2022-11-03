require "rails_helper"

RSpec.describe "admin merchant edit page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants/#{@merchant_1.id}/edit"
  end

  it "shows a form with existing merchant attributes" do
    expect(page).to have_field("name", with: @merchant_1.name)
    expect(page).to_not have_field("name", with: @merchant_2.name)
  end

  it "redirects back to merchants amdin show page with updated info" do
    fill_in "name", with: "Nomi LLC"
    click_button "Submit"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Successfully Updated: Nomi LLC")
    expect(page).to have_content("Nomi LLC")
  end
end
