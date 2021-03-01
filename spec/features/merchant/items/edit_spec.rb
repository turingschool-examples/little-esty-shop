require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit a merchant's item's edit page (/merchants/merchant_id/items/item_id/edit)" do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'One')
      @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
      @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
      # @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Three Description', unit_price: 30)

      visit edit_merchant_item_path(@merchant_1.id, @item_2.id)
    end

  it 'I see a form filled in with the existing item attribute information' do
      expect(page).to have_field('item[name]', with: "#{@item_2.name}")
      expect(page).to have_field('item[description]', with: "#{@item_2.description}")
      expect(page).to have_field('item[unit_price]', with: "#{@item_2.unit_price}")
    end

  describe "When I update the information in the form and I click 'Submit'" do
      before :each do
        fill_in 'item[name]', with: "Honey"
        fill_in 'item[description]', with: "Bee barf"
        fill_in 'item[unit_price]', with: 100

        click_button 'Submit'
      end

      it 'Then I am redirected back to the item show page where I see the updated information' do
        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_2.id))

        expect(page).to have_content("Honey")
        expect(page).to have_content("Description: Bee barf")
        expect(page).to have_content("Price: 100")
      end

      it 'Then I see a flash message stating that the information has been successfully updated' do
        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_2.id))

        expect(page).to have_content('Item successfully updated')
      end

      it 'Then I am redirected back to the item show page where I see the updated information' do
        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_2.id))

        expect(page).to have_content("Honey")
        expect(page).to have_content("Description: Bee barf")
        expect(page).to have_content("Price: 100")
      end

      describe "When i go to item index page" do
        it 'Then I see a flash message stating that the information has been successfully updated' do
          expect(page).to have_content('Item successfully updated')
        end
      end
    end
  end
end
