require 'rails_helper'

RSpec.describe 'merchant dashboard' do 
    it 'displays the name of a merchant' do 
        merchant = Merchant.create!(name: "Schroeder-Jerde")

        visit "/merchants/#{merchant.id}/dashboard"

        expect(page).to have_content(merchant.name)
    end
end