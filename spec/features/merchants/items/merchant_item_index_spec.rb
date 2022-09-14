require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merch1 = create(:merchant)
    @item1 = @merch1.items.create!(name: "thing", description: "Some Latin", unit_price: 5700 )
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

      xit 'when item link is clicked, merchant is taken to item index page' do
        visit merchant_items_path(@merch1.id)

        click_link "#{@item2.name}"

        expect(current_path).to eq(merchant_item_path(@item2.id))
      end

      xit 'item index page lists item attributes' do
        visit merchant_items_path(@merch1.id)

        click_link "#{@item1.name}"

        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content("Current Selling Price: $57.00")

        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
      end
    end
  end
end