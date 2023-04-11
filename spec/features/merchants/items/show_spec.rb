require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items show page' do
    it 'I see all of my items information' do
      visit merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price_to_dollars)
      expect(page).to_not have_content(@item_9.name)

      visit merchant_item_path(@merchant_1, @item_9)

      expect(page).to have_content(@item_9.name)
      expect(page).to have_content(@item_9.description)
      expect(page).to have_content(@item_9.unit_price_to_dollars)
      expect(page).to_not have_content(@item_1.name)
    end
  end
end