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

        expect(current_path).to eq(edit_merchant_item_path(@merch2.id, @item4.id))
      end

      it 'there is a form with the existing item attribute information' do
        visit edit_merchant_item_path(@merch1.id, @item2.id)

        expect(page).to have_content("Update Name")
        expect(page).to have_content("Update Description")
        expect(page).to have_content("Update Unit Price")
      end

      it "When I update the information in the form and I click 'submit'" do
        visit edit_merchant_item_path(@merch1.id, @item2.id)

        expect(page).to have_button("Submit Changes")
      end

      it 'I am redirected back to the item show page' do
        visit edit_merchant_item_path(@merch1.id, @item2.id)

        fill_in 'Update Name:', with: 'New Name'
        fill_in 'Update Description:', with: 'Description new'
        fill_in 'Update Unit Price:', with: 69575

        click_button "Submit Changes"

        expect(current_path).to eq(merchant_item_path(@merch1.id, @item2.id))
      end
      xit 'I see the updated information' do
        visit edit_merchant_item_path(@merch2.id, @item5.id)

        fill_in "Update Name:", with: 'New Name'
        fill_in "Update Description:", with: 'Description new'
        fill_in "Update Unit Price:", with: 69575

        click_button "Submit Changes"

        expect(page).to have_content('New Name')
        expect(page).to have_content('Description new')
        expect(page).to have_content('Current Selling Price: $695.75')
      end
      xit 'I see a flash message stating that the information has been successfully updated' do
        visit edit_merchant_item_path(@merch2.id, @item5.id)

        fill_in "Update Name:", with: 'New Name'
        fill_in "Update Description:", with: 'Description new'
        fill_in "Update Unit Price:", with: 69575

        click_button "Submit Changes"

        expect(page).to have_content("#{@item5.name} has been successfully updated.")
      end
    end
  end
end