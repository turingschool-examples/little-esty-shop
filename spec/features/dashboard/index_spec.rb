require 'rails_helper'

RSpec.describe "Dashboard Index" do 
    it 'will have a header indicating that this is the admin dashboard page' do 
        visit(admin_dashboard_index_url) 
        expect(page).to have_content("Admin Dashboard")
    end
    it 'will have a link to the admin merchants index page' do 
        visit(admin_dashboard_index_url)
        expect(page).to have_link("Admin Merchants Index")
        click_link("Admin Merchants Index")
        expect(current_path).to eq("/admin/merchants")
    end
    it 'will have a link to the admin invoices index page' do 
        visit(admin_dashboard_index_url)
        expect(page).to have_link("Admin Invoices Index")
        click_link("Admin Invoices Index")
        expect(current_path).to eq("/admin/invoices")
    end
end