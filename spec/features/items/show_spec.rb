require 'rails_helper'

RSpec.describe 'the merchant item show page' do
  before do

    @merchant1 = Merchant.create!(name: "Hondo MacGuillicutty", created_at: Time.now, updated_at: Time.now)
    @item1 = Item.create!(name: "Left-handed back scratcher", description: "Finally a solution for left-handed people with itchy backs", unit_price: 25, created_at: Time.now, updated_at: Time.now, merchant_id: @merchant1.id)

    visit "merchants/#{@merchant1.id}/items/#{@item1.id}"
  end

  describe 'page display' do
    it 'shows all the items attributes' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end

    it 'has a link to the item update page' do
      click_link("Update This Item")
    end

  end
end
