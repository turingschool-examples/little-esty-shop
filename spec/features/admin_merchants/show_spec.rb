require 'rails_helper'

describe 'Admin Merchants show page' do
  describe 'As an admin' do
    describe 'When I click on the name of a merchant from the admin merchants index page' do
      it "I am taken to that merchant's admin show page (/admin/merchants/merchant_id) and I see the name of that merchant" do
        merchant_1 = Merchant.create!(name: 'The Best Goods')

        visit admin_merchants_path
        # save_and_open_page
        click_link('The Best Goods')
        # save_and_open_page
        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("#{merchant_1.name}")
      end
    end
  end
end