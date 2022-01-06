require 'rails_helper'

RSpec.describe "items/new", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Joe Shmoe")
    @item_1 = @merchant_1.items.create!(name: "Light Machine", description: "Revolutionary Device", unit_price: 999)
    visit new_merchant_item_path(@merchant_1)
  end

  it "renders new item form" do
    fill_in(:name, with: "PB&J")
    fill_in(:description, with: "Lightly used.")
    fill_in(:unit_price, with: 1000)
    click_button "Create"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/")
    save_and_open_page
    expect(page).to have_content("PB&J")
    click_link "PB&J"
    expect(page).to have_content("Lightly used.")
    expect(page).to have_content("1000")
  end
end
