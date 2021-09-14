require 'rails_helper'

RSpec.describe 'merchants items index page' do
  before :each do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5, enable: 0)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10, enable: 0)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100, enable: 0)
  end

  it 'displays merchant item names' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
  end

  it 'has a link to items show page' do
    visit "/merchants/#{@merchant.id}/items"

    click_on "#{@item_1.name}"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
  end

  it 'has a button for enable/disable item' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'allows you to click enable' do
    visit "/merchants/#{@merchant.id}/items"

    @item_2.update(enable: 1)

    within("#item-#{@item_2.id}") do
      click_on "Enable"
    end

    @item_2.reload
    expect(@item_2.enable).to eq("enabled")
  end

  it 'allows you to click disable' do
    visit "/merchants/#{@merchant.id}/items"

    within("#item-#{@item_2.id}") do
      click_on "Disable"
    end

    @item_2.reload

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/")
    expect(@item_2.enable).to eq("disabled")
  end

  it 'has an enabled only section' do
    visit "/merchants/#{@merchant.id}/items"

    within("#enabled") do
      within("#item-#{@item_2.id}") do
        expect(@item_2.enable).to eq("enabled")
        expect(page).to have_content("#{@item_2.name}")
        click_on "Disable"
      end
    end
  end

  it 'has an disabled only section' do
    visit "/merchants/#{@merchant.id}/items"

    within("#disabled") do
      within("#item-#{@item_3.id}") do
        expect(@item_3.enable).to eq("disabled")
        expect(page).to have_content("#{@item_3.name}")
      end
    end
  end

  it 'has a link to create a new item' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_link("Create new item")
    click_link "Create new item"
    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
  end


end
