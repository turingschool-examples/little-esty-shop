require 'rails_helper'

RSpec.describe 'Merchant Items Index Page: ' do
  before :each do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, unit_price: 5700)
    @item2 = create(:item, merchant: @merch1)

    @merch2 = create(:merchant)
    @item3 = create(:item, merchant: @merch2)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
  end

  describe 'As a Merchant' do
    describe 'I visit my merchant items index page' do
      it 'I see a list of all my items' do
        visit merchant_items_path(@merch1.id)

        expect(page).to have_content(@merch1.name)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)

        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
      end

      it 'items are linked to items index page' do
        visit merchant_items_path(@merch2.id)

        within("#item_#{@item3.id}") do
          expect(page).to have_link("#{@item3.name}")
          expect(page).to_not have_link("#{@item4.name}")
          expect(page).to_not have_link("#{@item5.name}")
        end

        within("#item_#{@item4.id}") do
          expect(page).to have_link("#{@item4.name}")
          expect(page).to_not have_link("#{@item3.name}")
          expect(page).to_not have_link("#{@item5.name}")
        end

        expect(page).to have_link("#{@item5.name}")
      end
    end
  end
end