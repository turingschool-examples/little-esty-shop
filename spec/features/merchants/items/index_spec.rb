require 'rails_helper'

RSpec.describe 'merchant item index', type: :feature do
  before do
    @merchant = create(:merchant)

    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
  end

  it 'displays all items' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
  end

  it 'can toggle the status from the index page' do
    visit "/merchants/#{@merchant.id}/items"

    within "#item-#{@item1.id}" do
      expect(@item1.status).to eq("disabled")

      click_button "Enable"

      expect(@item1.status).to eq("enabled")
    end
  end
end
