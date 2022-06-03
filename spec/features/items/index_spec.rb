require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: 'Merchant1')
    @merchant2 = Merchant.create!(name: 'Merchant2')

    @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111, status: 0)
    @item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111,status: 0)
    @item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222, status: 0)
    

    visit "/merchants/#{@merchant1.id}/items"

  end

  describe 'Merchant items index page content' do
    it 'shows all items for the merchant' do
      expect(page).to have_content("Item1")
      expect(page).to have_content("Item11")
      expect(page).to_not have_content("Item2")
    end
  end
end
