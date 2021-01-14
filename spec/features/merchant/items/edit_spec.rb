require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit a merchant's item's edit page (/merchants/merchant_id/items/item_id/edit)" do
    before :each do
      @max = Merchant.create!(name: 'Merch Max')
      @item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)

      visit "merchants/#{@max.id}/items/#{@item_1.id}/edit"
    end

    it 'I see a form filled in with the existing item attribute information' do
      expect(page).to have_selector("input[id='item_name'][value='#{@item_1.name}']")
      expect(page).to have_selector("input[id='item_description'][value='#{@item_1.description}']")
      expect(page).to have_selector("input[id='item_unit_price'][value='#{@item_1.unit_price}']")
    end

    describe "When I update the information in the form and I click 'Submit'" do
      before :each do
        fill_in 'Name:', with: 'Legumes'
        fill_in 'Description:', with: 'A new and improved description'
        fill_in 'Unit Price:', with: '10'

        click_button 'Submit'
      end

      it 'Then I am redirected back to the item show page where I see the updated information' do
        expect(current_path).to eq(merchant_item_path(@max.id, @item_1.id))

        expect(page).to have_content('Legumes')
        expect(page).to have_content("Description: A new and improved description")
        expect(page).to have_content("Price: 10")
      end

      it 'Then I see a flash message stating that the information has been successfully updated' do
        expect(page).to have_content('Item Updated Successfully')
      end
    end

    describe "When I DO NOT enter the information in the form and I click 'Submit'" do
      before :each do
        fill_in 'Name:', with: ''
        fill_in 'Description:', with: 'This should error'
        fill_in 'Unit Price:', with: '10'

        click_button 'Submit'
      end

      it 'Then I see a flash message stating that the item did not update' do
        expect(page).to have_content('Item Update Failed')
      end

      it "Then I am redirected back to the merchant's item's edit page" do
        
        expect(current_path).to eq(edit_merchant_item_path(@max.id, @item_1.id))
      end
    end
  end
end
