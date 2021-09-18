require 'rails_helper'

RSpec.describe "merchant items index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1, status: 1)
    @item_2 = create(:item, merchant: @merchant_1, status: 0)
    @item_3 = create(:item, merchant: @merchant_2, status: 1)
    @item_4 = create(:item, merchant: @merchant_2, status: 0)
  end

  it 'lists the names of all merchant items' do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_4.name)

    visit merchant_items_path(@merchant_2)

    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to_not have_content(@item_1.name)
    expect(page).to_not have_content(@item_2.name)
  end

#   As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed

  it 'has a disable button' do
    visit merchant_items_path(@merchant_1)
    within("#enabled-#{@item_1.id}") do
      click_button("Disable")
    end
    within("#disabled-#{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
    end
  end

  it 'has an enable button' do
    visit merchant_items_path(@merchant_1)
    within("#disabled-#{@item_2.id}") do
      click_button("Enable")
    end
    within("#enabled-#{@item_2.id}") do
      expect(page).to have_content(@item_2.name)
    end
  end
end
