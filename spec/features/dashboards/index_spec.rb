require 'rails_helper'

RSpec.describe 'merchant dashboard page', type: :feature do
  let!(:merch_1) { Merchant.create!(name: 'name_1') }

  before(:each) { visit merchant_dashboards_path(merch_1) }

  describe 'as a user' do
    describe 'view elements' do
      it 'displays the merchants name' do
        expect(page).to have_content(merch_1.name)
      end
    end
    describe 'view links' do
      it "displays link to merchant item index " do

        expect(page).to have_link("Merchant Items")
        click_link "Merchant Items"
        expect(current_path).to eq(merchant_items_path(merch_1))

      end
      it "displays link to merchant invoices index" do
        expect(page).to have_link("Merchant Invoices")
        click_link "Merchant Invoices"
        expect(current_path).to eq(merchant_invoices_path(merch_1))
      end
    end
  end
end
