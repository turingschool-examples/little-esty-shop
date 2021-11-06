require 'rails_helper'

RSpec.describe "Merchant's Item Show Page" do
  before do
    @merchant1 = Merchant.create!(name: 'Willms and Sons')
    @item1 = @merchant1.items.create!(name: "Item 1", description: "An item", unit_price: 1300)
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
  end

  describe "when i visit the merchant's item show page" do
    it "i see the item's name, description and unit price" do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end
end