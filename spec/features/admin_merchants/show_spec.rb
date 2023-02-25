require 'rails_helper'

describe 'Admin Merchants show page' do
  describe 'As an admin' do
    before do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
    end
    describe 'When I click on the name of a merchant from the admin merchants index page' do
      it "I am taken to that merchant's admin show page (/admin/merchants/merchant_id) and I see the name of that merchant" do
        visit admin_merchants_path

        click_link("#{@merchant_1.name}")
     
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
      end
    end

    describe 'link to update a merchant' do
      before do
        visit admin_merchant_path(@merchant_1.id)
      end

      it 'takes me to the admin merchant edit page' do
        click_link('Update Merchant')
        expect(current_path).to eq(edit_admin_merchant_path(@merchant_1.id))
      end
    end
  end
end