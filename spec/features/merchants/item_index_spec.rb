require 'rails_helper'


RSpec.describe 'Merchant Item Index Page' do

  before do

    @merch1 = Merchant.create!(name: 'Jeffs Gold Blooms', created_at: Time.now, updated_at: Time.now)
    @item1 = @merch1.items.create!(name: "Golden Rose", description: "24k gold rose", unit_price: 100, created_at: Time.now, updated_at: Time.now, status: 1)
    @item2 = @merch1.items.create!(name: 'Dark Sole Shoes', description: "Dress shoes", unit_price: 200, created_at: Time.now, updated_at: Time.now)
    visit "/merchants/#{@merch1.id}/items"
  end

  describe 'As a Merchant' do

    it 'items index page shows my items' do
      expect(page).to have_content("Golden Rose")
      expect(page).to have_content('Dark Sole Shoes')
    end

    it 'every item name is a link to its show page' do
      click_link(@item1.name)
      expect(current_path).to eq("/merchants/#{@merch1.id}/items/#{@item1.id}")
          
    end

    it 'has a button to enable or disable each item' do
      within "#disabled-items" do
        expect(page).to_not have_content("Golden Rose")
        expect(page).to have_content("Dark Sole Shoes")
        click_button "Enable"
      end

      within "#disabled-items" do
        expect(page).to_not have_content("Golden Rose")
        expect(page).to_not have_content("Dark Sole Shoes")
      end
      
      within "#enabled-items" do
        expect(page).to have_content("Golden Rose")
        expect(page).to have_content("Dark Sole Shoes")
      end
    end
  end

end
# As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed