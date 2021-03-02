require 'rails_helper'

RSpec.describe "Merchant Item Edit Page" do
  before(:each) do
    @merchant = create(:merchant)

    @item = create(:item, merchant: @merchant)
  end

  describe "As a merchant" do
    describe "From the Merchant Item Show Page" do
      describe "When I click on the 'Update Item' link" do
        it "takes me to the edit item page" do
          visit merchant_item_path(@merchant, @item)

          expect(page).to have_link("Update Item")
          click_link("Update Item")
          expect(current_path).to eq(edit_merchant_item_path(@merchant, @item))
         end
      end
    end

    describe "Item Edit Page" do
      it "has a form with the data from the item" do
        visit edit_merchant_item_path(@merchant, @item)
        
        expect(page).to have_field('item[name]')
        expect(page).to have_field('item[description]')
        expect(page).to have_field('item[unit_price]')
        
        expect(find_field('item[name]').value).to eq(@item.name)
        expect(find_field('item[description]').value).to eq(@item.description)
        expect(find_field('item[unit_price]').value).to eq("#{@item.unit_price}")
      end
      
    end
    
    describe "when form is filled out and submitted" do
      it "takes me back to the Item's show page" do
        visit edit_merchant_item_path(@merchant, @item)

        fill_in 'item[name]', with: "New Item Name"
        fill_in 'item[description]', with: "A fancy new Item"
        fill_in 'item[unit_price]', with: 5

        click_button "Update Item"
        expect(current_path).to eq(merchant_item_path(@merchant, @item))

        expect(page).to have_content("New Item Name")
        expect(page).to have_content("A fancy new Item")
        expect(page).to have_content(5)
      end

      it "shows a flash message stating the information has been updated" do
        visit edit_merchant_item_path(@merchant, @item)

        fill_in 'item[name]', with: "New Item Name"
        fill_in 'item[description]', with: "A fancy new Item"
        fill_in 'item[unit_price]', with: 5

        click_button "Update Item"

        expect(page).to have_content("Your item has been successfully updated")
      end

      it "shows an error message if the information is not filled in" do
        visit edit_merchant_item_path(@merchant, @item)

        fill_in 'item[name]', with: "New Item Name"
        fill_in 'item[description]', with: ""
        fill_in 'item[unit_price]', with: 5

        click_button "Update Item"

        expect(page).to have_content("ERROR: Missing required information")
      end
    end
  end
end
