require 'rails_helper'


RSpec.describe 'Merchant Item Index Page' do

  before do

    @merch1 = Merchant.create!(name: 'Jeffs Gold Blooms', created_at: Time.now, updated_at: Time.now)
    @merch2 = Merchant.create!(name: 'Miyazakis Dark Souls', created_at: Time.now, updated_at: Time.now)
    @item1 = @merch1.items.create!(name: "Golden Rose", description: "24k gold rose", unit_price: 100, created_at: Time.now, updated_at: Time.now)
    @item2 = @merch2.items.create!(name: 'Dark Sole Shoes', description: "Dress shoes", unit_price: 200, created_at: Time.now, updated_at: Time.now)
    visit "/merchants/#{@merch1.id}/items"
  end

  describe 'As a Merchant' do

    it 'items index page shows my items' do

      expect(page).to have_content("Golden Rose")
      expect(page).to_not have_content('Dark Sole Shoes')
    end

    it 'every item name is a link to its show page' do
      click_link(@item1.name)
      expect(current_path).to eq("/merchants/#{@merch1.id}/items/#{@item1.id}")
          save_and_open_page
    end

  end

end


# As a merchant,
# When I visit my merchant items index page ("merchant/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
