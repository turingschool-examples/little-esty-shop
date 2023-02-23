require 'rails_helper'

RSpec.describe '/admin', type: :feature do
  describe 'when I visit the admin dashboard' do
    before do 
      # admin_path
      visit '/admin'
    end

    it 'I see a header indicating that I am on the admin dashboard' do
      expect(page).to have_content("Admin Dashboard Page")
    end

    it "I see a link to the admin merchants index & admin invoices index pages" do
      expect(page).to have_link("Admin Merchants Page", :href=>"/admin/merchants")
      expect(page).to have_link("Admin Invoices Page", :href=>"/admin/invoices")
    end

  end
end