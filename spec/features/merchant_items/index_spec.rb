require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  let!(:merchant) { create(:merchant) }
  let!(:item) { create(:item, merchant: merchant, status: 1)}
  let!(:item2) { create(:item, merchant: merchant, status: 0)}
  let!(:item4) { create(:item, merchant: merchant, status: 1)}
  let!(:item5) { create(:item, merchant: merchant, status: 0)}
  let!(:item3) { create(:item, status: 0)}

  describe 'merchant items' do
    it 'has list of items for a specific merchant' do
      visit "/merchants/#{merchant.id}/items"
      # save_and_open_page
      expect(page).to have_content(item.name)
      expect(page).to have_content(item2.name)
      expect(page).to_not have_content(item3.name)
    end
  end

  describe 'merchant items links on index page' do 
    it 'has links for the item names' do 
      visit "/merchants/#{merchant.id}/items"
      within ".merchant-items-disabled" do 
        click_link "#{item2.name}"
      end
      expect(current_path). to eq("/merchants/#{merchant.id}/items/#{item2.id}")

      visit "/merchants/#{merchant.id}/items"
      within ".merchant-items-enabled" do 
        click_link "#{item.name}"
      end 
      expect(current_path). to eq("/merchants/#{merchant.id}/items/#{item.id}")
    end 
  end

  describe 'merchant item disable/enable' do 
    it 'has a button to enable and a button to disable item' do 
      visit "/merchants/#{merchant.id}/items"
      # save_and_open_page
      within ".merchant-items-enabled" do 
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end 
      within ".merchant-items-disabled" do 
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
      end 
    end

    it 'redirects back to items index with changed status when clicked' do 
      visit "/merchants/#{merchant.id}/items"

      within ".merchant-items-enabled" do
        expect(page).to have_content(item.name)
        expect(item.status).to eq("Enabled")
        click_button("#{item.id}")
      end 
      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      within ".merchant-items-enabled" do 
        expect(page).to_not have_content(item.name)
        item.reload
        expect(item.status).to eq("Disabled")
      end 

      within ".merchant-items-disabled" do
        expect(page).to have_content(item2.name)
        expect(item2.status).to eq("Disabled")
        click_button("#{item2.id}")
      end 
      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      within ".merchant-items-disabled" do 
        expect(page).to_not have_content(item2.name)
        item2.reload
        expect(item2.status).to eq("Enabled")
      end 
    end

    it 'can group by status' do 
      visit "/merchants/#{merchant.id}/items"

      within ".merchant-items-enabled" do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content(item.name)
        expect(page).to have_content(item4.name)
        expect(page).to_not have_content(item2.name)
        expect(page).to_not have_content(item5.name)
      end

      within ".merchant-items-disabled" do
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item5.name)
        expect(page).to_not have_content(item.name)
        expect(page).to_not have_content(item4.name)
      end
    end
  end

  describe 'merchant item create' do 
    it 'has a link to create a new item' do 
      visit "/merchants/#{merchant.id}/items"

      expect(page).to have_link("Create New Item")
    end
  end
end
