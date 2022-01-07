require 'rails_helper'

RSpec.describe 'merchant dashboard page', type: :feature do
  let!(:merch_1) { Merchant.create!(name: 'name_1') }

  before(:each) { visit merchant_dashboard_path(merch_1) }

  describe 'as a user' do
    describe 'view elements' do
      it 'displays the merchants name' do
        expect(page).to have_content(merch_1.name)  
      end
    end
  end
end