require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: 'Merchant1')
    @merchant2 = Merchant.create!(name: 'Merchant2')
    @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111, status: 0)
    @item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111,status: 1)
    @item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222, status: 0)

    visit "/merchants/#{@merchant1.id}/items"
  end
  
  describe 'Merchant items index page content' do
    it 'shows all items for the merchant' do
      expect(page).to have_content("Item1")
      expect(page).to have_content("Item11")
      expect(page).to_not have_content("Item2")
    end
  end
  
  describe "instance variable" do
    it "change the status of the item" do
      @merchant1 = Merchant.create!(name: 'Merchant1')
      @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111)
      visit "/merchants/#{@merchant1.id}/items"
      
      within("#status-#{@item1.id}") do
        expect(page).to have_content("Status: enabled")
      end
      
      click_button "Disable"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      
      within("#status-#{@item1.id}") do
        expect(page).to have_content("Status: disabled")
      end  
      
      click_button "Enable"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      
      within("#status-#{@item1.id}") do
        expect(page).to have_content("Status: enabled")
      end
    end
  end
  
  describe "Index Page Content" do
    it "items are placed into the section, enabled or disabled, that matches their status" do
      item111 = @merchant1.items.create!(name: 'Item111', description: 'Description111', unit_price: 11111, status: 1)
      item1111 = @merchant1.items.create!(name: 'Item1111', description: 'Description1111', unit_price: 111111, status: 0)
      
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_content("Enabled Items")
      expect(page).to have_content("Disabled Items")
      
      within("#enabled_items") do
        expect(page).to have_content("Item1")
        expect(page).to have_content("Item1111")
        expect(page).to_not have_content("Item11 ")
      end
      
      within("#disabled_items") do
        expect(page).to have_content("Item11")
        expect(page).to have_content("Item111")
        expect(page).to_not have_content("Item1 ")
      end
    end
  end

  describe 'creating a new item' do
    it 'has button to link to a create new item page' do
    expect(page).to have_button("Create Item")

    click_button "Create Item"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
    save_and_open_page
    end
  end
end