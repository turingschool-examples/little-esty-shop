require 'rails_helper'

RSpec.describe 'Items/new' do
  let!(:merchant1) { create(:merchant) }

  before do
    visit "merchants/#{merchant1.id}/items/new"
  end
  context 'on merchant new item page' do
    it 'I see a form to create a new item' do
      expect(page).to have_content("Create a New Item")
      expect(page).to have_field(:name)
      expect(page).to have_field(:description)
      expect(page).to have_field(:unit_price)
      expect(page).to have_button("Submit")
    end
  end

  context 'I fill out info and click submit and I am taken back to the items index page' do
    it 'the merchant/item index page shows the new information' do
      fill_in "Name:", with: "Doo-dad"
      fill_in "Description:", with: "Doo-dad things"
      fill_in "Unit Price:", with: "100"

      click_on "Submit"

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")

      expect(page).to have_content("Doo-dad")
      expect(Item.first.status).to eq("disabled")
      # expect(page).to have_content("Status: disabled")
    end
  end

  context 'sad path, invalid form info' do
    it 'the merchant/item index page displays flash message' do
      fill_in "Name:", with: "Doo-dad"
      fill_in "Description:", with: "Doo-dad things"
      fill_in "Unit Price:", with: "Mike"

      click_on "Submit"

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")

      expect(page).to have_content('Invalid input')
    end
  end
end