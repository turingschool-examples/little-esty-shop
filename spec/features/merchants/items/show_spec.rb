require "rails_helper"

RSpec.describe "Merchant Items Show Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant2 = Merchant.create!(name: "Williamson Group")

    @item1 = @merchant1.items.create!(name: "Item Ea Voluptatum", description: "A thing that does things", unit_price: 7654)
    @item2 = @merchant1.items.create!(name: "Item Quo Magnam", description: "A thing that does nothing", unit_price: 10099)
    @item3 = @merchant1.items.create!(name: "Item Voluptatem Sint", description: "A thing that does everything", unit_price: 8790)
    @item4 = @merchant2.items.create!(name: "Item Rerum Est", description: "A thing that barks", unit_price: 3455)
    @item5 = @merchant2.items.create!(name: "Item Itaque Consequatur", description: "A thing that makes noise", unit_price: 7900)
  end
  describe "when I visit this page " do
    it "has the items listed with of of its attribues" do
      visit "/merchants/#{@merchant1.id}/items"

      click_on "Item Quo Magnam"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item2.id}")
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item2.unit_price)
      expect(page).to_not have_content(@item4.name)
    end
  end
end
