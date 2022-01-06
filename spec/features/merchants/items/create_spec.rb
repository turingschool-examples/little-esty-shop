require 'rails_helper'

RSpec.describe "Merchant Item Create page" do

  it "has a form for new item, and redirects to merchant items index with new item listed" do
    merchant1 = create(:merchant)
    visit "merchants/#{merchant1.id}/items/new"

    within('#create_item') do
      fill_in "Name:", with: "Paul's Item"
      fill_in "Description", with: "An item from Paul"
      fill_in "Unit Price:", with: 1000
      click_button "Submit"

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")
      expect(page).to have_content("Paul's Item")
      expect(page).to have_content("An item from Paul")
      expect(page).to have_content(1000)
    end
  end
end
