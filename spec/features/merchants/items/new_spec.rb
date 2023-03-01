require 'rails_helper'

RSpec.describe 'New Merchant Item Record' do
  let!(:carlos) { Merchant.create!(name: "Carlos Jenkins") }

  describe 'Form to add item information' do
    it 'should have fields to enter new item information' do
      visit "/merchants/#{carlos.id}/items/new"
      expect(page).to have_field("Name")
      expect(page).to have_field("Description")
      expect(page).to have_field("Unit Price")
      expect(page).to have_button("Create Item")
    end

    describe 'I fill out the form, click `Submit`' do
      it 'I am taken back to the items index page' do
        visit "/merchants/#{carlos.id}/items/new"

        fill_in :name, with: "Teacup"
        fill_in :description, with: "Here's a Teacup"
        fill_in :unit_price, with: 300

        click_on "Create Item"
        expect(current_path).to eq("/merchants/#{carlos.id}/items")
      end

      it "If the information is not valid or missing, item is not created" do
        visit "/merchants/#{carlos.id}/items/new"

        fill_in :name, with: ""
        fill_in :description, with: "Here's a Teacup"
        fill_in :unit_price, with: 300

        click_button "Create Item"
        expect(current_path).to eq("/merchants/#{carlos.id}/items/new")
        expect(page).to have_content("Item not created: Required information missing")

        fill_in :name, with: "Teacup"
        fill_in :description, with: ""
        fill_in :unit_price, with: 300

        click_button "Create Item"
        expect(current_path).to eq("/merchants/#{carlos.id}/items/new")
        expect(page).to have_content("Item not created: Required information missing")
        
        fill_in :name, with: "Teacup"
        fill_in :description, with: "Here's a Teacup"
        fill_in :unit_price, with: ""

        click_button "Create Item"
        expect(current_path).to eq("/merchants/#{carlos.id}/items/new")
        expect(page).to have_content("Item not created: Required information missing")

        # fill_in :name, with: "Teacup"
        # fill_in :description, with: "Here's a Teacup"
        # fill_in :unit_price, with: "abc"

        # click_button "Create Item"
        # expect(current_path).to eq("/merchants/#{carlos.id}/items/new")
        # expect(page).to have_content("Item not created: Required information missing")
      end
    end
  end
end