require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see all of my items' do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
    end
  end
end