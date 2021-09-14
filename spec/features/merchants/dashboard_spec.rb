require 'rails_helper'
# rspec spec/features/merchants/dashboard_spec.rb
RSpec.describe 'Merchant Dashboard Show Page' do
  describe 'Merchant Dashboard Show Page' do
    let!(:merchant1) { create(:merchant) }

    before :each do
      visit merchant_dashboard_path(merchant1.id)
    end

    it 'shows merchant dashbaord attributes' do

      expect(page).to have_content(merchant1.name)
    end

    describe 'links' do
      it 'has links to the merchants items' do
        click_on 'Items'

        expect(current_path).to eq(merchant_items_path(merchant1))
      end

      it 'has links to the merchants Invoices' do
        click_on 'Invoices'

        expect(current_path).to eq(merchant_invoices_path(merchant1))
      end
    end
  end
end
