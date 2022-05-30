require 'rails_helper'

RSpec.describe Item, type: :feature do
  describe 'show page' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Merchant1', created_at: Time.now, updated_at: Time.now)
      @merchant2 = Merchant.create!(name: 'Merchant2', created_at: Time.now, updated_at: Time.now)
      @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111, created_at: Time.now, updated_at: Time.now)
      @item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111, created_at: Time.now, updated_at: Time.now)
      @item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222, created_at: Time.now, updated_at: Time.now)
    end
    
    it 'is linked from item on index page' do
      visit "/merchants/#{@merchant1.id}/items"
      click_on 'Item1' 
      expect(current_path).to be("merchants/#{@merchant1.id}/items/#{@item1.id}")
    end
  end
end