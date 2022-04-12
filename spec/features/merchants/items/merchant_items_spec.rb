require 'rails_helper'

RSpec.describe 'Merchant items index' do
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

    visit "/merchants/#{@starw.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

#      save_and_open_page
      expect(page).to have_current_path("/merchants/#{@starw.id}/items")
      expect(page).to have_content(@starw.name)
      expect(page).to_not have_content(@start.name)

    end
  end
end
