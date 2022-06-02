require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: 'Merchant1', created_at: Time.now, updated_at: Time.now)
    @merchant2 = Merchant.create!(name: 'Merchant2', created_at: Time.now, updated_at: Time.now)
    @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111, created_at: Time.now, updated_at: Time.now)
    @item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111, created_at: Time.now, updated_at: Time.now)
    @item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222, created_at: Time.now, updated_at: Time.now)
    
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

