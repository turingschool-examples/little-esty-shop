require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Show' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    describe 'As a merchant' do 
      context "When I visit my merchant's item's show page" do
        it 'I see the item name and all of its attributes' do
          visit merchant_item_path(sam.id, football.id)
          
          expect(page).to have_content(football.name)

          within 'div#item_attributes' do
            expect(page).to have_content("Description: #{football.description}")
            expect(page).to have_content("Current Selling Price: $30.00")
            expect(page).to have_content("Current Selling Price: $#{football.unit_price / 100}")
          end
        end
      end
    end
  end
end