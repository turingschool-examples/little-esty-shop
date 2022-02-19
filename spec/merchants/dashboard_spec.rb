require 'rails_helper'

 RSpec.describe 'Merchant Dashboard' do
   it "when visiting merchant dashboard I see name of merchant" do
     merchant_1 = Merchant.create!(name: 'Circuit City Jr')

     visit "/merchants/#{merchant_1.id}/dashboard"
     save_and_open_page

     expect(page).to have_content('Circuit City Jr')
   end
 end
