require 'rails_helper'

RSpec.describe Item, type: :feature do
  describe 'show page' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Merchant1')
      @merchant2 = Merchant.create!(name: 'Merchant2')
      @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111)
      @item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111)
      @item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222)
      visit "/merchants/#{@merchant1.id}/items"
    end
    
    it 'is linked from item name on index page and shows all attributes of item' do
          
      click_on 'Item1' 
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

      expect(page).to have_content("Description1")
      expect(page).to have_content("$1.11")
      expect(page).to have_content("Item1")
    end

    it "has an update link to an edit page form with fields prepopulated with items current information" do
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
      click_on "Update"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
        expect(page).to have_field(:name, with: "Item1")
        expect(page).to have_field(:description, with: "Description1")
        expect(page).to have_field(:unit_price, with: "$1.11")
    end

    it 'update button will change attribute values, has a success flash message' do
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
      click_on "Update"
        fill_in "Name", with: "Item1newname"
        fill_in "Description", with: "NewDescription1"
        fill_in "Unit Price", with: "121"
        click_on "Update"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      expect(page).to have_content("Item1newname")
      expect(page).to have_content("NewDescription1")
      expect(page).to have_content("$1.21")
    end
  end
end
