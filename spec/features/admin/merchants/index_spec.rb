require 'rails_helper'

RSpec.describe 'Admin/merchant index' do
  describe 'When I visit the admin/merchant index (/admin/merchant)' do
    before (:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @merchant_10 = create(:merchant)
      @merchant_11 = create(:merchant)
      @merchant_12 = create(:merchant)
    end
    it 'Then I see the name of each merchant in the system' do
      visit "/admin/merchants"
      save_and_open_page
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("#{@merchant_1.name}")
      expect(page).to have_content("#{@merchant_2.name}")
      expect(page).to have_content("#{@merchant_3.name}")
      expect(page).to have_content("#{@merchant_4.name}")
      expect(page).to have_content("#{@merchant_5.name}")
      expect(page).to have_content("#{@merchant_6.name}")
      expect(page).to have_content("#{@merchant_7.name}")
    end
  end
end
