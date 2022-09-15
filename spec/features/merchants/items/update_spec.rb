require 'rails_helper'

RSpec.describe 'Merchant Item Update Page: ' do
  before :each do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, unit_price: 5700)
    @item2 = create(:item, merchant: @merch1)

    @merch2 = create(:merchant)
    @item3 = create(:item, merchant: @merch2)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
  end

  describe 'As a merchant' do
    describe 'when I visit the merchant show page of an item' do
      it 'when update link is clicked, merchant is taken to a page to edit the item.' do
        visit merchant_item_path(@merch2.id, @item4.id)

        click_link "Update #{@item4.name}"

        expect(current_path).to eq("the path goes here")
      end

      it 'there is a form with the existing item attribute information' do
        visit "the path goes here"

        expect(page).to have_content("Update #{item.name}")
        expect(page).to have_content("Update #{item.description}")
        expect(page).to have_content("Update #{item.unit_price}")
      end

      it "When I update the information in the form and I click 'submit'" do
        visit "the path goes here"

        expect(page).to have_button("Sumbit Changes")
      end

      it 'I am redirected back to the item show page' do
        visit "the path goes here"

        fill_in "Update #{item.name}"
        fill_in "Update #{item.description}"
        fill_in "Update #{item.unit_price}"

        click_button "Submit Changes"

        expect(current_path).to eq("new path")
      end
      it 'I see the updated information' do
        visit "the path goes here"

        fill_in "Update #{item.name}"
        fill_in "Update #{item.description}"
        fill_in "Update #{item.unit_price}"

        expect(page).to have_content("item.name")
        expect(page).to have_content("item.description")
        expect(page).to have_content("Updated sale price")
      end
      it 'I see a flash message stating that the information has been successfully updated' do
        visit "the path goes here"

        fill_in "Update #{item.name}"
        fill_in "Update #{item.description}"
        fill_in "Update #{item.unit_price}"

        expect(page).to have_content("#{item.name} has been successfully updated.")
      end
    end
  end
end