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

#   As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:
  describe 'user story 7' do
    it 'When I click on the name of an item I am taken to that merchant item show page' do

      visit "/merchants/#{@merchant_1.id}/items"

      within("#merchant-items") do
        click_on "#{@items_1[0].name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@items_1[0].id}")
      end

      visit "/merchants/#{@merchant_2.id}/items"

      within("#merchant-items") do
        click_on "#{@items_2[6].name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@items_2[6].id}")
      end
    end

    it 'I see all of the items attributes' do

      @items_1.each do |item|
        visit merchant_item_path(@merchant_1, item)
        within("#item-attributes") do
          expect(page).to have_content(item.name)
          expect(page).to have_content(item.description)
          expect(page).to have_content(item.unit_price)
        end
      end

      @items_2.each do |item|
        visit merchant_item_path(@merchant_2, item)
        within("#item-attributes") do
          expect(page).to have_content(item.name)
          expect(page).to have_content(item.description)
          expect(page).to have_content(item.unit_price)
        end
      end
    end
  end
end
