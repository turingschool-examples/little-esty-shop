require 'rails_helper'

describe 'Admin Merchants show page' do
  describe 'As an admin' do
    describe 'When I click on the name of a merchant from the admin merchants index page' do
      it "I am taken to that merchant's admin show page (/admin/merchants/merchant_id) and I see the name of that merchant" do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        visit admin_merchants_path
    
        click_link("#{merchant_1.name}")
     
        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to_not have_content("#{merchant_2.name}")
      end
    end
  end
end