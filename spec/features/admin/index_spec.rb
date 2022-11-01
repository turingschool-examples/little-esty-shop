require 'rails_helper'

RSpec.describe 'Admin Index' do
    before :each do 
      visit '/admin'
    end

    it "has a header" do 
      expect(page).to have_content("Admin Dashboard")
    end

    it "has links" do 
      expect(page).to have_link('admin merchants index')
      expect(page).to have_link('admin invoices index')
    end


end