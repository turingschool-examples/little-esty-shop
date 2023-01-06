require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  describe 'As an admin, When I visit an admin merchant show page' do
    it 'shows the attributes for the corresponding merchant' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit admin_merchant_path(@merchant_2)

      expect(page).to have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_1.name)
    end

    describe 'shows a a link to update the merchant\'s information' do
      describe 'when clicked a page to edit this merchant via form (pre-populated with existing merchant attribute information' do
        it 'redirects back to the merchant\'s admin show page where I see the updated information after clicking submit and shows a flash message' do
          visit admin_merchant_path(@merchant_1)

          click_on('Edit Merchant')
          expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

          save_and_open_page
          fill_in('merchant_name', with: 'Jeremy')
          click_on('Update Merchant')
          expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
          expect(page).to have_content(@merchant_1.name)
          expect(page).to have_content('Jeremy')
          expect(Admin::MerchantsController).to set_flash.now[:notice].to(/Merchant Updated/)
        end
      end
    end
  end
end
