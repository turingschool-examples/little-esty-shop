require 'rails_helper'

RSpec.describe 'the merchants items index' do
  describe 'as a merchant' do

    xit 'each item on my items index is a link to the show page' do
      merchant = Merchant.create(name: 'Toys and Stuff')
      item = merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )

      visit "/merchants/#{merchant.id}/items"
      click_on item.name

      expect(current_path).to eq "/merchants/#{merchant.id}/items/#{item.id}"
    end

    describe 'item create' do
      before :each do
        @merchant = Merchant.create(name: 'Toys and Stuff')
      end

      it 'I see a link to create a new item' do
        visit "/merchants/#{@merchant.id}/items"

        expect(page).to have_link "Create a new item"

        click_link "Create a new item"

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/new"
      end

      it 'the page has a form that creates a new item when submitted' do
        visit "/merchants/#{@merchant.id}/items/new"
        fill_in :name, with: 'fidget spinner'
        fill_in :description, with: 'it spins'
        fill_in :price, with: '15.00'
        click_on 'Save'

        expect(current_path).to eq "/merchants/#{@merchant.id}/items"
        expect(page).to have_content 'fidget spinner'
        # user story says the item's status should be disabled by default?
        # items don't have a status so I'm not sure about this one...
      end
    end
  end
end
