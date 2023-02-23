require 'rails_helper'

describe 'Admin Merchants index page' do
  describe 'As an admin' do
    describe 'When I visit the admin merchants index (/admin/merchants)' do
      it "Then I see the name of each merchant in the system" do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        visit admin_merchants_path
      
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end
  end
end