require 'rails_helper'

RSpec.describe 'Merchant Item Show Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_2 = create_list(:item, 10, merchant: @merchant_2)
  end

  # As a merchant,
  # When I visit the merchant show page of an item
  # I see a link to update the item information.
  # When I click the link
  # Then I am taken to a page to edit this item
  # And I see a form filled in with the existing item attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the item show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.

  describe 'User Story 8 - When I visit the merchant show page of an item' do 
    it ' I see a link to update the item information and when I click I am take to edit page' do

      @items_1.each do |item|
        visit merchant_item_path(@merchant_1, item)
        click_on "Update #{item.name}"
        expect(current_path).to eq(edit_merchant_item_path(@merchant_1, item))
      end

      @items_2.each do |item|
        visit merchant_item_path(@merchant_2, item)
        click_on "Update #{item.name}"
        expect(current_path).to eq(edit_merchant_item_path(@merchant_2, item))
      end 
    end

    it 'And I see a form filled in with the existing item attribute information' do
      @items_1.each do |item|
        visit edit_merchant_item_path(@merchant_1, item)

        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end 

      @items_2.each do |item|
        visit edit_merchant_item_path(@merchant_2, item)

        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end 
    end

    it 'I update information in form and I click ‘submit’ Then redirected back to item show page where I see updated information' do

      visit edit_merchant_item_path(@merchant_1, @items_1[0])

      fill_in "item[name]", with: "Blue"
      fill_in "item[description]", with: "Orange"
      fill_in "item[unit_price]", with: "1000"
      click_on "Update Item"

      expect(current_path).to eq(merchant_item_path(@merchant_1, @items_1[0]))

      expect(page).to have_content("Blue")
      expect(page).to have_content("Orange")
      expect(page).to have_content("1000")
    end
  end
end