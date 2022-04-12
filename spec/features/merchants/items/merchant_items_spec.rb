require 'rails_helper'

RSpec.describe 'Merchant items index' do
  before do
    @merchant1 = Merchant.create!(name: "Star Wars R Us ")

    @item1 = Item.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 0,
                          merchant_id: @merchant1.id
                         )

    @item2 = Item.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0,
                          merchant_id: @merchant1.id
                         )

    visit "/merchants/#{@merchant1.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

      binding.pry
      save_and_open_page
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content(@merchant1.name)

    end
  end
end
