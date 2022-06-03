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
    it 'has a button to enable item' do 
      visit "/merchants/#{merchant.id}/items"
      # save_and_open_page
      within ".merchant-items-enabled" do 
        expect(page).to have_button("Disable")
      end 
      within ".merchant-items-disabled" do 
        expect(page).to have_button("Enable")
      end 
    end

    it 'redirects back to items index with changed status when clicked' do 
      visit "/merchants/#{merchant.id}/items"

      within ".merchant-items-enabled" do 
        click_button("#{item.id}")
      end 
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      within ".merchant-items-enabled" do 
        expect(page).to_not have_content(item.name)
      end 
      item.reload
      expect(item.status).to eq("Disabled")
      within ".merchant-items-disabled" do 
        click_button("#{item2.id}")
      end 
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      within ".merchant-items-disabled" do 
        expect(page).to_not have_content(item2.name)
      end 
      item2.reload
      expect(item2.status).to eq("Enabled")
    end
  end
end
