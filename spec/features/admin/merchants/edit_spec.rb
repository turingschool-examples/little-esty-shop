  require 'rails_helper'

RSpec.describe 'admin merchant update page' do

  it 'allows you to update a merchant and return to the show page' do
    merchant_1 = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)

    visit "/admin/merchants/#{merchant_1.id}/edit"

      fill_in "Name", with: "Al Capone"
      within "#edit_merchant_name" do
      expect(page).to have_field("Name", with: "Al Capone")
      
      click_on 'Update Merchant'
      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    end
  end

end
