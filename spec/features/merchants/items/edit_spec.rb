require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before do
    @starw = Merchant.create!(name: "Star Wars R Us ")
    @start = Merchant.create!(name: "Star Trek R Us ")

    @item1 = @starw.items.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 0
                         )

    @item2 = @starw.items.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0
                         )

    visit edit_merchant_item_path(@starw,@item1)
  end

  it 'has a prepopulated form for the item' do


    expect(page).to have_field('Name', with: 'X-wing')
    expect(page).to have_field('Description', with: 'X-wing ship')
    expect(page).to have_field('Unit price', with: '75107')

  end

   it 'can edit attributes and redirect' do
     
     fill_in('Name', with: 'Y-wing')
     fill_in('Description', with: 'Y-wing ship')
     fill_in('Unit price', with: '2000')
     click_button("Submit")
     expect(current_path).to eq(merchant_item_path(@starw,@item1))
     expect(page).to have_content("Y-wing")
     expect(page).to have_content("Y-wing ship")
     expect(page).to_not have_content("X-wing")

     expect(page).to have_content("Update Successful")

   end
end
