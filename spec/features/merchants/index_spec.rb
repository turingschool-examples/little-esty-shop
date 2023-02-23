require 'rails_helper'
RSpec.describe Merchant, type: :feature do 

  describe 'Merchant Dashboard' do

    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 

    before (:each) do 
      visit merchant_dashboard_index_path(bob.id)
    end

    describe 'As a merchant' do 
      context 'When I visit merchant dashboard' do 

        it 'displays the name of my merchant' do
          expect(page).to have_content("Name: Bob's Beauties")
          expect(page).to have_content("Name: #{bob.name}")
        end

        it 'displays a link to my merchant items index' do
          expect(page).to have_link('My Items')
        end
      
        it 'displays a link to my merchant invoices index' do
          expect(page).to have_link('My Invoices')
        end
      end
    end
  end
end