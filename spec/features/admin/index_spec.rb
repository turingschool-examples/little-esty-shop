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

    it 'sees a list of all the ids of all invoices that have items that have not been shipped' do 
        customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
        customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
        customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
        customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
        customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

        invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
        invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id )
        invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id )
        invoice_4 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_4.id )
        invoice_5 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
        invoice_6 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_6.id )

        transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
        transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
        transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
        transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
        transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
        transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )

        visit '/admin'
        
        within ("#column2") do 
            expect(page.all('.invoice')[0]).to have_content("Id:")
            expect(page.all('.invoice')[1]).to have_content("Id:")
            expect(page.all('.invoice')[2]).to have_content("Id:")
            expect(page.all('.invoice')[3]).to have_content("Id:")
        end 
    end 

    xit 'links to invoice admin show page' do 
        visit '/admin'
        
        within ("#column2") do
            click_on("Id:")
        end 
        expect(current_path).to eq("/admin/invoices/#{id.id}")
    end 

    xit 'shows the date the incomplete invoice was created and in order from oldest to newest' do 
        visit '/admin'
        
        within ("#column2") do 
            expect(page.all('.invoice')[0]).to have_content("Date:")
            expect(page.all('.invoice')[1]).to have_content("Date:")
            expect(page.all('.invoice')[2]).to have_content("Date:")
            expect(page.all('.invoice')[3]).to have_content("Date:")
        end 
    end 
end 

# customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
# customer_2 = Customer.create!(first_name: "Kyle", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
# customer_3 = Customer.create!(first_name: "Bert", last_name: "Kyleson", created_at: Time.now, updated_at: Time.now)
# customer_4 = Customer.create!(first_name: "Randall", last_name: "Bertson", created_at: Time.now, updated_at: Time.now)
# customer_5 = Customer.create!(first_name: "Craig", last_name: "Randalson", created_at: Time.now, updated_at: Time.now)
# customer_6 = Customer.create!(first_name: "Geoff", last_name: "Craigson", created_at: Time.now, updated_at: Time.now)

# invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
# invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id )
# invoice_3 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id )
# invoice_4 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_4.id )
# invoice_5 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id )
# invoice_6 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_6.id )

# transaction_1 = Transaction.create!(credit_card_number:4444555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_1.id )
# transaction_2 = Transaction.create!(credit_card_number:4445555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_2.id )
# transaction_3 = Transaction.create!(credit_card_number:4446555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_3.id )
# transaction_4 = Transaction.create!(credit_card_number:4447555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_4.id )
# transaction_5 = Transaction.create!(credit_card_number:4448555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_5.id )
# transaction_6 = Transaction.create!(credit_card_number:4449555566667777, result: "succesful",created_at: Time.now, updated_at: Time.now, invoice_id:invoice_6.id )