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

    describe "Merchant Item Update" do
      it "a link takes me to a page to edit this item" do
        clink_on "Update Item"
      end

      it "i see a form filled in with the existing item attribute information" do
        #binding models to forms 
      end

      it "when i update and submit, i'm redirected back to the item show page where i see the changes" do
        fill_in "Name", with: "Item #1"
        fill_in "Description", with: "The first item"
        fill_in "Unit Price", with: 1400
        clink_on "Submit Update"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
        expect(page).to have_content("Item #1")
        expect(page).to have_content("The first item")
        expect(page).to have_content(1400)
      end

      it "i see a flash message stating that the information has geen successfully updated" do
        #flash message
      end
    end
  end
end