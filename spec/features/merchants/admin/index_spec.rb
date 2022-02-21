require 'rails_helper'

RSpec.describe 'admin merchant index' do
     it 'displays name of each merchant in the system' do
         merchant_1 = create(:merchant)
         merchant_2 = create(:merchant)
         merchant_3 = create(:merchant)
         merchant_4 = create(:merchant)

         visit '/admin/merchants'

         expect(page).to have_content(merchant_1.name)
         expect(page).to have_content(merchant_2.name)
         expect(page).to have_content(merchant_3.name)
         expect(page).to have_content(merchant_4.name)
         expect(page).to_not have_content(merchant_4.id)
    end
    
end