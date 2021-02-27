require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items'" do
  before :each do
    @merchant1 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id, status: false)
    @item5 = create(:item, merchant_id: @merchant1.id, status: false)
    @item6 = create(:item, merchant_id: @merchant1.id, status: false)
  end

  it "shows link to create new item" do
    visit merchant_items_path(@merchant1)

    click_link "Create a New Item"

    expect(current_path).to eq(new_merchant_item_path(@merchant1))
  end

  it "Can create a new item" do
    visit new_merchant_item_path(@merchant1)

    fill_in 'name', with: "New Item"
    fill_in 'description', with: "Some description"
    fill_in 'unit_price', with: 5.5
    click_button "Create Item"
    expect(current_path).to eq(merchant_items_path(@merchant1))

    expect(page).to have_content("New Item Created")

    within(".disabled_items") do
      expect(page).to have_content("New Item")
    end
  end

  it "Does not create item without a name" do
    visit new_merchant_item_path(@merchant1)

    fill_in 'name', with: " "
    fill_in 'description', with: "Some description"
    fill_in 'unit_price', with: 5.5
    click_button "Create Item"
    expect(current_path).to eq(merchant_items_path(@merchant1))

    expect(page).to have_content("Required Information Missing")
  end
end
# When I visit my items index page
# I see a link to create a new item.
# When I click on the link,
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.
