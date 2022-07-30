require 'rails_helper'

RSpec.describe 'admin merchant update page' do
  describe '#edit' do
    it 'edit form contains current merchant information' do

      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      visit "admin/merchants/#{merchant_1.id}/edit"

      expect(page).to have_field('Merchant Name', with: 'Spongebob The Merchant')
    end
  end

  describe "#input updated data" do
    it 'update merchant name and redirect to admin merchant show page with updated information' do

      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      visit "admin/merchants/#{merchant_1.id}/edit"

      fill_in "Merchant Name", with: "Spongebob The Bestest Merchant"
      click_button "Submit"

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content("Spongebob The Bestest Merchant")
    end
  end
end