require 'rails_helper'

# Merchant Item Disable/Enable
#
# As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed

RSpec.describe "items/index", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Joe Shmoe")
    @merchant_2 = Merchant.create!(name: "Jane Shmoe")

    @item_1 = @merchant_1.items.create!(name: "Light Machine", description: "Revolutionary Device", unit_price: 999)
    @item_2 = @merchant_1.items.create!(name: "Shiny Stone", description: "It's shiny", unit_price: 9)
    @item_3 = @merchant_2.items.create!(name: "Molly Doll", description: "What is it", unit_price: 500)
    visit merchant_items_path(@merchant_1)
  end

  it 'has the names of merchant items' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'has button that goes to new page' do
    click_link "Create New Item"
    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
  end


  xit 'has an enable button' do
    click_button "Enable"
    expect(@item_1.status).to eq("Enabled")
  end
end
