require 'rails_helper'

RSpec.describe "new admin merchant creation" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:merchant2) { Merchant.create!(name: "Target") }
  let!(:merchant3) { Merchant.create!(name: "Walgreens") }
  let!(:merchant4) { Merchant.create!(name: "Hot Topic", status: 1) }

  before do
    visit new_admin_merchant_path
  end

  describe 'the merchant new' do
    it "renders the new merchant form" do
      expect(page).to have_content('New Merchant')
      expect(find('form')).to have_content('Name')
    end
  end

  describe 'the merchant create' do
    context 'given valid data' do
      it "can fill out a form to create a new merchant and display the default status of disabled" do
        fill_in 'merchant[name]', with: "Backcountry"
        click_button

        expect(current_path).to eq(admin_merchants_path)

        within ".disabled-merchants" do
          expect(page).to have_content('Backcountry')
          expect(page).to have_content('Status: Disabled')
        end
      end
    end
  end
end
