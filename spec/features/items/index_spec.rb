require 'rails_helper'

describe "merchant items index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    visit merchant_items_path(@merchant1)
  end

  it "can see a list of all the names of my items and not items for other merchants" do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)

    expect(page).to have_no_content(@item_5.name)
    expect(page).to have_no_content(@item_6.name)
  end

  it "has links to each item's show pages" do
    expect(page).to have_link(@item_1.name)
    expect(page).to have_link(@item_2.name)
    expect(page).to have_link(@item_3.name)
    expect(page).to have_link(@item_4.name)

    click_link "#{@item_1.name}"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item_1.id}")
  end

  it "can make a button to disable items" do
    within("#item-#{@item_1.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      click_button "Disable"

      item = Item.find(@item_1.id)
      expect(item.status).to eq("disabled")
    end
    within("#item-#{@item_2.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      click_button "Disable"
      expect(@item_2.status).to eq("disabled")
    end
    within("#item-#{@item_3.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      click_button "Disable"
      expect(@item_3.status).to eq("disabled")
    end
  end

  it "has a section for disabled items" do
    within("#disabled") do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_1.name)
    end
  end

  it "has a section for enabled items" do
    within("#enabled") do
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
      expect(page).to have_content(@item_1.name)
    end
  end

  it "has a link to create a new item" do
    click_link "Create New Item"
    expect(current_path).to eq(new_merchant_item_path(@merchant1))
    fill_in "Name", with: "Bar Shampoo"
    fill_in "Description", with: "Eco friendly shampoo"
    fill_in "Unit price", with: "15"
    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(@merchant1))

    within("#disabled") do
      expect(page).to have_content("Bar Shampoo")
    end
  end
end
