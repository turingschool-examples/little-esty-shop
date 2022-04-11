require 'rails_helper'

RSpec.describe 'Merchant items index' do
  before do
    @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
    @item1 = @merchant1.Item.create!(name:	"Item Qui Esse",
                          description: "this item has a description",
                          unit_price:75107,
                          status: 0,
                         )

    visit "merchant/#{@merchant.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

      expect(page).to have_current_path("merchant/#{@merchant.id}/items"
      expect(page).to have_content(@merchant1.name)

    end
  end
end
