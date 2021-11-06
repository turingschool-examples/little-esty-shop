require 'rails_helper'

RSpec.describe 'Item index page', type: :feature do
before(:each) do
      @merchant1 = Merchant.create!(name: 'Willms and Sons')
      @item1 = @merchant1.items.create!(name: "Item 1", description: "An item", unit_price: 1300)
      @item2 = @merchant1.items.create!(name: "Item 2", description: "Another item", unit_price: 1200)
      @item3 = @merchant2.items.create!(name: "Item 3", description: "Another other item", unit_price: 1240)
    
      visit "/merchants/#{@merchant1.id}/items"
    end

    describe 'merchant item index page' do
      it 'shows a merchants items' do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end
end