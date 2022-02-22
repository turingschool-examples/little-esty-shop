require 'rails_helper'

RSpec.describe "Merchant Item Create page" do
  describe "when I visit the merchant item create page," do
    it "has a form for a new item, once filled out and submitted it redirect to index with item listed" do
      merchant_1 = Merchant.create!(name: "Staples")
      visit "merchants/#{merchant_1.id}/items/new"

      within('#create_item') do
        fill_in "Name", with: "Paul's new item"
        fill_in "Description", with: "An item made by paul"
        fill_in "Unit Price:", with: 1000
        click_button "Create Item"
      end

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
      expect(merchant_1.items.last.name).to eq("Paul's new item")
    end
  end
end
