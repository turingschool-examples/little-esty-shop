require 'rails_helper'

RSpec.describe 'admin merchants show page', type: :feature do
  before(:each) do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "Buck-an-Ear Jewelry")
    @merch_3 = Merchant.create!(name: "Orange You Glad")
    @merch_4 = Merchant.create!(name: "Absolutely Authentic Autographs")
  end

  it "displays only that merchant" do
    visit "admin/merchants"
    click_link "Orange You Glad"

    expect(page).to have_content(@merch_3.name)
    expect(page).to_not have_content(@merch_1.name)
    expect(page).to_not have_content(@merch_2.name)
    expect(page).to_not have_content(@merch_4.name)
  end

  it "links to merchant edit form" do
    visit "admin/merchants/#{@merch_3.id}"
    click_link "Update Merchant"

    expect(current_path).to eq("/admin/merchants/#{@merch_3.id}/edit")
  end

end