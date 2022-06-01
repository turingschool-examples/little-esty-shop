require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do
  let!(:merchant_1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant_2) { Merchant.create!(name: "Willms and Sons") }

  let!(:item_1) { merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item_2) { merchant_1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item_3) { merchant_2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }

  before do
    visit merchant_items_path(merchant_1)
  end

  it "displays only a specified merchant's items" do
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to_not have_content(item_3.name)
  end

  it "can click a button to disable or enable a specific item" do
    within ".enabled-items" do
      expect(page).to_not have_content("Qui Esse")
    end

    within ".disabled-items" do
      within "#item-#{item_1.id}" do
        expect(page).to have_content("Qui Esse")
        expect(page).to have_button("Enable")
        expect(page).to_not have_content("Autem Minim")

        click_button "Enable"
        save_and_open_page
      end
    end
    expect(current_path).to eq(merchant_items_path(merchant_1))

    within ".enabled-items" do
      within "#item-#{item_1.id}" do
        expect(page).to have_content("Qui Esse")
        expect(page).to have_button("Disable")

        click_button "Disable"
      end
    end
  end
end
