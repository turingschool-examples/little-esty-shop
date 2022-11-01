require 'rails_helper'

RSpec.describe 'admin merchants index page' do 
  describe 'admin merchants index' do 
    it 'displays name of each merchant in the system' do 
      merchant1 = Merchant.create!(name: 'Marys Tractors')

      visit "/admin/merchants"
      
      save_and_open_page
      expect(page).to have_content(merchant1.name)
    end
  end 
end