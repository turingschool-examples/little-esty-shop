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
    describe 'top customers' do 
        before :each do 
            @customer_1 = create(:customer, first_name: 'Aaron', last_name: 'Adams')
            @customer_2 = create(:customer, first_name: 'Barry', last_name: 'Bonds')
            @customer_3 = create(:customer, first_name: 'Carl', last_name: 'Cassidy')
            @invoice_1 = create(:invoice, customer_id: @customer_1.id)
            @invoice_2 = create(:invoice, customer_id: @customer_1.id)
            @invoice_3 = create(:invoice, customer_id: @customer_1.id)
            @invoice_4 = create(:invoice, customer_id: @customer_2.id)
            @invoice_5 = create(:invoice, customer_id: @customer_2.id)
            @invoice_6 = create(:invoice, customer_id: @customer_3.id)
            @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
            @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 0)
            @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 0)
            @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 0)
            @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 0)
            @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)
        end
        it 'will return the names and transaction count of the top 2 customers' do 
            visit(admin_dashboard_index_url)
            within ".top_customers" do 
                expect(page).to have_content(@customer_1.first_name)
                expect(page).to have_content(@customer_1.last_name)
                expect(page).to have_content("Successful Transactions: 3")
            end
        end
    end
end