require 'rails_helper'


RSpec.describe 'the merchant item index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
  end

  it "will show merchants item names" do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_4.name)
  end

  it "Can enable and disable an item" do
    visit "/items/#{@item_1.id}"

    expect(page).to have_content("Status: Disabled")

    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_button("Enable #{@item_1.name}")

    click_button("Enable #{@item_1.name}")

    expect(current_path).to eq("/items/#{@item_1.id}")

    expect(page).to have_content("Status:")

    @item_1.reload

    expect(@item_1.status).to eq("Enabled")
  end

  it "the names of merchants are links to their show page" do
    visit "/merchants/#{@merchant_1.id}/items"

    click_link("#{@item_1.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

    visit "/merchants/#{@merchant_1.id}/items"

    click_link("#{@item_2.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}")
  end

  it "Has Enabled and Disabled section on index page" do
    @enabled_item = @merchant_1.items.create!(name: "pen", description: "red ink", unit_price: 5, status: "Enabled")
    
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content('Enabled Items')
    expect(page).to have_content('Disabled Items')

    within ".enabled_items" do
      expect(page).to have_content(@enabled_item.name)
    end

    within ".disabled_items" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
    end
  end

end
