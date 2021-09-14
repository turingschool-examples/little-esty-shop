require 'rails_helper'

RSpec.describe 'merchants items edit page' do
  before :each do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100)
  end

  it "displays a form" do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    expect(page).to have_content("Edit #{@item_1.name}")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Unit price")
    expect(page).to have_field("Name")
    expect(page).to have_field("Description")
    expect(page).to have_field("Unit price")
  end

  it "allows us to enter new information and click submit" do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    fill_in('Name', with: 'Keyboard')
    fill_in('Description', with: 'RGB')
    fill_in('Unit price', with: 4000)
    click_on "Submit"
    save_and_open_page
    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    expect(page).to have_content("Keyboard")
    expect(page).to have_content("RGB")
    expect(page).to have_content(4000)
    expect(page).to_not have_content("Lamp")
    expect(page).to_not have_content("Sheds light")
    expect(page).to_not have_content(5)
    expect(page).to have_content("Item has been updated succesfully")
  end
end
