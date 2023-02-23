require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature  do

  before :each do 
    @merchant = Merchant.create!(name: "dude")
  end

  describe ' As a Merchant ' do 
    describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)' do
      it "Then I see the name of my merchant " do
        visit merchant_dashboard_index_path(@merchant.id)

        expect(current_path).to eq("/merchant/#{@merchant.id}/dashboard")
        expect(page).to have_content(@merchant.name)
      end 
    end 
  end
end