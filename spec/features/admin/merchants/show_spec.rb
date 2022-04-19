require 'rails_helper'

RSpec.describe "Admin Merchant Show" do

    it 'has a link to edit the merchant' do

        @merchant_1 = Merchant.create!(
        name: "Wally World",
        created_at: Date.current,
        updated_at: Date.current)

        visit "/admin/merchants/#{@merchant_1.id}"


        
    end
    
end
