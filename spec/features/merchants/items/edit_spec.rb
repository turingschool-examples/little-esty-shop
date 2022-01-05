require 'rails_helper'

RSpec.describe "Merchant Item Edit Page" do

  it 'fills out form with existing item attribute info, click submit and taken back to item show page' do
    merchant1 = Merchant.create!(name: 'merchant1')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)

    visit edit_merchant_item_path(merchant1, item1)

    within '.edit_item_form' do
      expect(page).to have_content(item1.name)
      #expect(page).to have_content(item1.description)
      #expect(page).to have_content(item1.unit_price)
      fill_in 'name', with: "pizza"
      fill_in 'description', with: "has pineapples"
      click_on 'Submit'
    end
    save_and_open_page
    expect(current_path).to eq(merchant_item_path(merchant1, item1))

    within ".item" do
      expect(page).to have_content("pizza's Info")
      expect(page).to have_content('pizza')
      expect(page).to have_content('has pineapples')
      expect(page).to have_content(10000)
    end
    within '.flash' do
      expect(page).to have_content("pizza was successfully updated.")
    end
  end
end
