require 'rails_helper'

RSpec.describe 'admin merchant show' do
    it 'shows name of merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        visit "/admin/merchants/#{merchant_1.id}"

        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_3.name)
    end
end