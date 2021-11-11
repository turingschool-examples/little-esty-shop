require 'rails_helper'

RSpec.describe "merchant admin edit page" do
  before :each do
    @merchant = create(:merchant)
    visit "/admin/merchants/#{@merchant.id}/edit"
  end
describe 'edit form' do
  context 'when valid information entered' do
    it 'allows admin to edit merchant' do
      expect(page).not_to have_content "Goldman Sachs"
      expect(page).to have_field('Name', with: "#{@merchant.name}")

      fill_in 'Name', with: "Goldman Sachs"
      click_button "Submit"
      
      expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
      expect(page).to have_content "Information has been successfully updated"

      expect(page).to have_content "Goldman Sachs"
      expect(page).not_to have_content "Jade Rabbit"
    end
  end

  context 'when no information entered' do
    it 'provides error message and redirects to form' do
      click_button "Submit"
      
      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
      expect(page).to have_content "Failed to update merchant"

      expect(page).to have_content "#{@merchant.name}"
    end
  end
end
end