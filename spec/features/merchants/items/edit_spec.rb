require 'rails_helper'

RSpec.describe 'Merchant Item Update' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}

  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500) }

  describe 'when I arrive, I see a form to update the item' do
    it 'has fields filled out with current item attributes' do
      visit edit_merchant_item_path(carly, peanut)

      expect(page).to have_field('Name', with: peanut.name)
      expect(page).to have_field('Description', with: peanut.description)
      expect(page).to have_field('Current Price', with: peanut.unit_price)
    end

    describe 'when I update the information' do
      describe 'it updates the item, takes me back to item show' do
        it 'and displays flash msg feedback' do

          visit merchant_item_path(carly, peanut)

          expect(page).to have_content("Peanut Bronzinos")

          visit edit_merchant_item_path(carly, peanut)

          fill_in('Name', with: "Peanut Charles Bronson")
          click_on 'Submit'

          expect(current_path).to eq(merchant_item_path(carly, peanut))
          expect(page).to have_content("Peanut Charles Bronson")
          expect(page).to have_content("Item Successfully Updated")
        end
      end
    end
  end
end