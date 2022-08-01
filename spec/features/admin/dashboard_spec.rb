require 'rails_helper' 

RSpec.describe 'Admin Dashboard' do 
    it 'has a header that says admin dashboard' do
        visit '/admin'

        within "#header" do
            expect(page).to have_content("Admin Dashboard")
        end
    end    

    it 'has a header with links' do
        visit '/admin'

        within "#header" do
            expect(page).to have_link("Dashboard")
            expect(page).to have_link("Merchants")
            # click_on("Merchants")
            # expect(current_path).to eq('/admin/merchants')
        end

        visit '/admin'

        within "#header" do
            expect(page).to have_link("Invoices")
            # click_on("Invoices")
            # expect(current_path).to eq('/admin/invoices')
        end
    end  

    it 'lists top 5 customers by successful transaction' do
        8.times do
            Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
        end
        Customer.all.each.with_index do |customer, index|
            index.times do 
                customer.invoices.create!(status: Faker::Number.between(from: 0, to: 2) )
            end
        end
        Invoice.all.each do |invoice|
            invoice.transactions.create!(result: "success", credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
        end
        20.times do
            Transaction.create!(result: "failed",invoice_id: Faker::Number.between(from: Invoice.first.id, to: Invoice.last.id), credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
        end

        visit '/admin'

        within "#top-customers" do
            expect("#{Customer.last.first_name} #{Customer.last.last_name}").to appear_before("#{Customer.fifth.first_name} #{Customer.fifth.last_name}")
            expect("#{Customer.fifth.first_name} #{Customer.fifth.last_name}").to appear_before("#{Customer.fourth.first_name} #{Customer.fourth.last_name}")
            expect(page).to_not have_content("#{Customer.first.first_name} #{Customer.first.last_name}")
        end
    end

    it 'displays the transaction count of top 5 customers' do
        8.times do
            Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
        end
        Customer.all.each.with_index(1) do |customer, index|
            index.times do 
                customer.invoices.create!(status: Faker::Number.between(from: 0, to: 2) )
            end
        end
        Invoice.all.each do |invoice|
            invoice.transactions.create!(result: "success", credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
        end
        20.times do
            Transaction.create!(result: "failed",invoice_id: Faker::Number.between(from: Invoice.first.id, to: Invoice.last.id), credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
        end
        customers = Customer.top_5_by_transaction

        visit '/admin'

        within "#top-customers" do
            expect(page).to have_content("1. #{customers.first.first_name} #{customers.first.last_name} - 8 purchases")
            expect(page).to have_content("2. #{customers.second.first_name} #{customers.second.last_name} - 7 purchases")
        end
    end

    it 'shows links to incomplete invoices which have items that havent shipped' do
        merchant = Merchant.create!(name: 'Mike Dao')
        customer = Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
        8.times do
            Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: Faker::Number.digit, merchant_id: merchant.id )
        end
        10.times do
            invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
            InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
            InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
        end
        invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
        InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'shipped', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))

        visit '/admin'

        within "#incomplete-invoices" do
            expect(page).to have_link("Invoice ##{Invoice.first.id}")
            expect(page).to have_link("Invoice ##{Invoice.fifth.id}")
            expect(page).to_not have_content("Invoice ##{Invoice.last.id}")
        end

        # click_on("Invoice ##{Invoice.first.id}")
        # expect(current_path).to eq("/admin/invoices/#{Invoice.first.id}")
    end

    it 'orders incomplete invoices oldest first and shows date' do
        merchant = Merchant.create!(name: 'Mike Dao')
        customer = Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
        8.times do
            Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: Faker::Number.digit, merchant_id: merchant.id )
        end
        10.times do
            invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
            InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
            InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
        end
        invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
        InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'shipped', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))

        visit '/admin'

        within "#incomplete-invoices" do
            expect("Invoice ##{Invoice.first.id}").to appear_before("Invoice ##{Invoice.second.id}")
            expect("Invoice ##{Invoice.second.id}").to appear_before("Invoice ##{Invoice.third.id}")
            expect(page).to have_content("Invoice ##{Invoice.first.id} - #{Invoice.first.created_at.strftime("%A, %B %d, %Y")}")
        end
    end
end