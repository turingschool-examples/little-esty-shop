require 'rails_helper'

RSpec.describe 'Merchant Item Edit page' do
  describe "when I click on 'Update This Item' on the show page" do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, merchant_id: @merchant1.id)
    end

    it 'takes me to the edit url' do
      visit "merchant/#{@merchant1.id}/items/#{@item1.id}"

      click_on "Update This Item"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}/edit")
    end

    it 'has a form' do
      visit "/merchant/#{@merchant1.id}/items/#{@item1.id}/edit"

      expect(page).to have_field("name")
      expect(page).to have_field("description")
      expect(page).to have_field("unit_price")
      expect(page).to have_button('Submit')
    end

    it 'autofills the form with the information in the database' do
      visit "/merchant/#{@merchant1.id}/items/#{@item1.id}/edit"

      expect(page).to have_field("name", :with => "magic pen")
      expect(page).to have_field("description", :with => "special")
      expect(page).to have_field("unit_price", :with => 9.10)
    end

    it 'allows the user to make changes to the items' do
      visit "/merchant/#{@merchant1.id}/items/#{@item1.id}/edit"

      fill_in 'name', with: 'best pen'
      fill_in 'description', with: 'magical'
      fill_in 'unit_price', with: 2.20

      click_on 'Submit'

      expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}")

      expect(page).to have_content('best pen')
      expect(page).to have_content('magical')
      expect(page).to have_content(2.20)

      expect(page).not_to have_content('magic pen')
      expect(page).not_to have_content('special')
      expect(page).not_to have_content(9.10)
    end

    it 'does not allow the user to leave a field blank' do
      visit "/merchant/#{@merchant1.id}/items/#{@item1.id}/edit"

      fill_in 'name', with: ''
      click_on 'Submit'
      expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}/edit")
      expect(page).to have_content("Error")
      expect(page).to have_button('Submit')
    end

    it 'shows a flash message stating that the update was successful' do
      visit "/merchant/#{@merchant1.id}/items/#{@item1.id}/edit"

      fill_in 'name', with: 'Something else'
      click_on 'Submit'

      expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}")
      expect(page).to have_content('Submission Successful')
    end
  end
end
