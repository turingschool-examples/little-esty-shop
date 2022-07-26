require 'rails_helper'

RSpec.describe 'admin index' do 

    it 'has an index page' do 
        visit '/admin'

        expect(page).to have_content("Admin Dashboard")
    end 

    it 'has a link to a merchant index' do 
        visit '/admin'

        expect(page).to have_content("Merchants")

        click_on("Merchants")

        expect(current_path).to eq('/admin/merchants')
    end 

    it 'has a link to a merchant index' do 
        visit '/admin'

        expect(page).to have_content("Invoices")

        click_on("Invoices")

        expect(current_path).to eq('/admin/invoices')
    end 

    it 'see the names of top 5 customers' do 
        visit '/admin'
        expect(page).to have_content("Top 5 Customers")
    
    end 

    it 'sees a section for incomplete invoices' do 
        visit '/admin'
        expect(page).to have_content("Incomplete Invoices")
    end 
end 