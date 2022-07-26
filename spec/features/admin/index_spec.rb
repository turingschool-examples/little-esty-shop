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

    xit 'sees a list of all the ids of all invoices that have items that have not been shipped' do 
        visit '/admin'
        
        within ("#column2") do 
            expect(page.all('.invoice')[0]).to have_content("Id:")
            expect(page.all('.invoice')[1]).to have_content("Id:")
            expect(page.all('.invoice')[2]).to have_content("Id:")
            expect(page.all('.invoice')[3]).to have_content("Id:")
        end 
    end 

    it 'links to invoice admin show page' do 
        visit '/admin'
        
        within ("#column2") do
            click_on("Id:")
        end 
        expect(current_path).to eq("/admin/invoices/#{id.id}")
    end 
end 