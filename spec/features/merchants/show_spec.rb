require 'rails_helper'
RSpec.describe Merchant, type: :feature do 

  describe 'Merchant dashboard' do

    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 

    before (:each) do 
      visit merchant_dashboard_index_path(bob.id)
    end

    it 'displays the name of my merchant' do
      expect(page).to have_content("Name: Bob's Beauties")
      expect(page).to have_content("Name: #{bob.name}")
    end
  end
end