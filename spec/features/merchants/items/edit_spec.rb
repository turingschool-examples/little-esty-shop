require 'rails_helper'

RSpec.describe 'merchant items edit page', type: :feature do
  describe "as a merchant, when I visit my merchant items edit page ('/merchant/merchant_id/items/item_id')" do
    let!(:merchant1) { create(:merchant)}

    let!(:item1) {create(:item, merchant: merchant1)}  

    describe 'I see a form filled in with the existing item attribute information' do
      it "When I update the information in the form and I click ‘submit’" do
        visit edit_merchant_item_path(merchant1, item1)
        old_name = item1.name
              
        fill_in :name, with: "Fancier Item"

        click_button
        
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
        expect(page).to have_content("Fancier Item")
        expect(page).to_not have_content(old_name)

      end
    end
  end
end