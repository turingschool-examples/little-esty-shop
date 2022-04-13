require 'rails_helper'

RSpec.describe 'Merchant items new page' do
  before do
    @starw = Merchant.create!(name: "Star Wars R Us ")
    @start = Merchant.create!(name: "Star Trek R Us ")

    @item1 = @starw.items.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 1
                         )

    @item2 = @starw.items.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0
                         )
    @item3 = @starw.items.create!(name:	"Lightsaber",
                          description: "Lightsaber",
                          unit_price:7500,
                          status: 1
                         )

    @item4 = @starw.items.create!(name:	"Luke",
                          description: "Luke SKywalker figure",
                          unit_price:1000
                         )

    visit new_merchant_item_path(@starw)
  end

  it 'has a form for a new item' do

      fill_in(:name, with: "Darth Vader")
      fill_in(:description, with: "Darth Vader 16 inch action figure")
      fill_in(:unit_price, with: 1000)

      click_button('Create Item')

      expect(current_path).to eq(merchant_items_path(@starw))
      expect(page).to have_content("Darth Vader")
      expect(page).to have_content("Darth Vader 16 inch action figure")
      expect(page).to have_content("$10")
  end
end
