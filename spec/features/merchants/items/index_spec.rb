require 'rails_helper'

RSpec.describe 'Mechants Item Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_2 = create_list(:item, 10, merchant: @merchant_2)

  end

  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  describe 'user story 6' do
    it 'I see a list of the names of all of my items' do

      visit merchant_items_path(@merchant_1)

      within("#merchant-items") do
        @items_1.each do |item|
          expect(page).to have_content(item.name)
        end
        @items_2.each do |item|
          expect(page).to_not have_content(item.name)
        end
      end

      visit merchant_items_path(@merchant_2)

      within("#merchant-items") do
        @items_2.each do |item|
          expect(page).to have_content(item.name)
        end
        @items_1.each do |item|
          expect(page).to_not have_content(item.name)
        end
      end
    end
  end
end
