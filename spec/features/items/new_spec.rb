require 'rails_helper'

RSpec.describe 'new page for items' do
  describe 'the form for new items' do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
    end

    it 'has fields and one hidden field' do
      visit "/merchant/#{@merchant1.id}/items/new"

      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      page.has_field? :merchant_id, type: :hidden, with: @merchant1.id
      expect(page).to have_field('unit_price')
    end

    it 'takes me back to the items index after filling form and submission' do
      visit "merchant/#{@merchant1.id}/items/new"

      fill_in 'name', with: 'Mysterious writer'
      fill_in 'description', with: 'it writes for you'
      fill_in 'unit_price', with: 10.35

      click_on 'Create Item'

      expect(current_path).to eq("/merchant/#{@merchant1.id}/items")
    end

    it 'shows errors if a field is left blank' do
      visit "merchant/#{@merchant1.id}/items/new"

      fill_in 'unit_price', with: 10.35

      click_on 'Create Item'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
end
