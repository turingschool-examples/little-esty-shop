require 'rails_helper'

RSpec.describe 'new merchant item', type: :feature do
  describe 'as a merchant' do 
    describe 'when I visit /merchants/:id/items/new' do
      before :each do
        @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        @surf_designs = Merchant.create!(name: "Surf & Co. Designs")
      end 

      xit '- I see a form that allows me to add new item information. when I fill out 
      the form, I click (submit). then I am directed back to the items index page.' do
        visit "/merchants/#{@surf_designs}/items/new"


      end
    end
  end
end