require 'rails_helper'

RSpec.describe 'Admin Index' do

  describe 'visit' do
    it 'Visits the Admin Dash' do
      visit '/admin'  

      expect(page).to have_content('Admin Dashboard')
    end
  end
end