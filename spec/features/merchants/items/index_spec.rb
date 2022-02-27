require 'rails_helper'

RSpec.describe 'merchant item index', type: :feature do
  it 'displays all items' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
  end

  it 'has links to each items show page' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"

    within "#item-#{item2.id}" do
      click_button "View item"
    end

    expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item2.id}")
  end

  it 'can toggle the status from the index page' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"


    within "#item-#{item1.id}" do

      expect(item1.status).to eq("disabled")

      click_button "enable"
      item1.reload

      expect(item1.status).to eq("enabled")
      expect(page).to have_content("enabled")
    end

    expect(page).to have_content("Item status updated!")
  end

  it 'after toggling the item will display in the correct column.' do
    merchant = create(:merchant)

    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)

    visit "/merchants/#{merchant.id}/items"
    within "#item-#{item1.id}" do
      expect(item1.status).to eq("disabled")

      click_button "enable"
      item1.reload
    end
    within("#enabled") do
      expect(item1.status).to eq("enabled")
      expect(page).to have_content("enabled")
    end

    within "#item-#{item2.id}" do
      expect(item2.status).to eq("disabled")
      click_button "enable"
      item2.reload
    end
    within("#enabled") do
      expect(item2.status).to eq("enabled")
    end
    expect(page).to have_content("Item status updated!")
  end


end
