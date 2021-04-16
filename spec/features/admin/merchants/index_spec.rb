require 'rails_helper'

RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants index' do
    it 'can show the name of each merchant in the system' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)

      visit '/admin/merchants'

      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
      expect(page).to have_content(merchant4.name)
    end

    it "has links to take me to a merchant's show page" do
      merchant1 = create(:merchant)

      visit '/admin/merchants'

      expect(page).to have_link("Link to this merchant")

      click_on("Link to this merchant")

      expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    end
  end
end
