require 'rails_helper' 
require 'faker' 
require 'pry'

RSpec.describe 'Admin Merchants Index' do 
    include ActiveSupport:: Testing::TimeHelpers 

    # Admin Merchants Index
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    it 'shows the name of each merchant in the system' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        visit admin_merchants_path
        save_and_open_page

        within('#e-merchant-0') do 
            expect(page).to have_content(merchant_1.name)
        end

        within('#e-merchant-1') do 
            expect(page).to have_content(merchant_2.name)
        end

        within('#e-merchant-2') do 
            expect(page).to have_content(merchant_3.name)
        end

        within('#e-merchant-3') do 
            expect(page).to have_content(merchant_4.name)
        end
    end

    # Admin Merchant Show
    # As an admin,
    # When I click on the name of a merchant from the admin merchants index page,
    # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
    # And I see the name of that merchant
    it 'has links to the merchants admin show page' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        visit admin_merchants_path

        within('#e-merchant-0') do 
            expect(page).to have_link(merchant_1.name)
        end

        within('#e-merchant-1') do 
            expect(page).to have_link(merchant_2.name)
        end

        within('#e-merchant-2') do 
            expect(page).to have_link(merchant_3.name)
        end

        within('#e-merchant-3') do 
            expect(page).to have_link(merchant_4.name)
            click_link(merchant_4.name)
        end

        expect(current_path).to eq("/admin/merchants/#{merchant_4.id}")
        expect(page).to have_content(merchant_4.name)
        expect(page).to_not have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_3.name)
    end

    # As an admin,
    # When I visit the admin merchants index
    # Then next to each merchant name I see a button to disable or enable that merchant.
    it 'has buttons to disable or enable Merchants' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name)

        visit admin_merchants_path

        within("#disabled") do 
            expect(page).to have_content merchant_1.name 
            expect(page).to have_content merchant_2.name 
            expect(page).to have_content merchant_4.name 
            expect(page).to_not have_content merchant_3.name
        end

        within("#enabled") do 
            expect(page).to have_content merchant_3.name 
            expect(page).to_not have_content merchant_1
            expect(page).to_not have_content merchant_2
            expect(page).to_not have_content merchant_4
        end

        within("#d-merchant-0") do 
            expect(page).to have_content merchant_1.name 
            expect(page).to have_button "Enable"
        end

        within("#d-merchant-1") do 
            expect(page).to have_content merchant_2.name 
            expect(page).to have_button "Enable"
        end

        within("#d-merchant-2") do 
            expect(page).to have_content merchant_4.name 
            expect(page).to have_button "Enable"
        end

        within("#e-merchant-0") do 
            expect(page).to have_content merchant_3.name 
            expect(page).to have_button "Disable"
        end
    end

    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed
    it 'has buttons that changes the merchants status' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        visit admin_merchants_path

        within("#e-merchant-0") do 
            click_on "Disable"
        end

        expect(current_path).to eq "/admin/merchants"

        within("#enabled") do 
            expect(page).to have_content merchant_2.name 
            expect(page).to have_content merchant_4.name 
            expect(page).to_not have_content merchant_1.name
            expect(page).to_not have_content merchant_3.name
        end

        within("#disabled") do 
            expect(page).to have_content merchant_1.name 
            expect(page).to have_content merchant_3.name 
            expect(page).to_not have_content merchant_2
            expect(page).to_not have_content merchant_4
        end

        visit admin_merchants_path

        within("#d-merchant-1") do 
            click_on "Enable"
        end

        within("#enabled") do 
            expect(page).to have_content merchant_2.name 
            expect(page).to have_content merchant_3.name
            expect(page).to have_content merchant_4.name 
            expect(page).to_not have_content merchant_1.name
        end

        within("#disabled") do 
            expect(page).to have_content merchant_1.name 
            expect(page).to_not have_content merchant_2
            expect(page).to_not have_content merchant_4
            expect(page).to_not have_content merchant_3
        end
    end

    # Admin Merchants Grouped by Status
    # As an admin,
    # When I visit the admin merchants index
    # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
    # And I see that each Merchant is listed in the appropriate section
    it 'groups merchants by status' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        visit admin_merchants_path

        within("#enabled") do 
            expect(page).to have_content merchant_2.name 
            expect(page).to have_content merchant_4.name 
            expect(page).to_not have_content merchant_1.name 
            expect(page).to_not have_content merchant_3.name
        end

        within("#disabled") do 
            expect(page).to have_content merchant_1.name 
            expect(page).to have_content merchant_3.name 
            expect(page).to_not have_content merchant_2
            expect(page).to_not have_content merchant_4
        end
    end

    # Admin Merchant Create
    # As an admin,
    # When I visit the admin merchants index
    # I see a link to create a new merchant.
    # When I click on the link,
    # I am taken to a form that allows me to add merchant information.
    it 'has a link to create a new merchant that directs to merchant#new' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name)

        visit admin_merchants_path
        click_link 'New Merchant' 

        expect(current_path).to eq '/admin/merchants/new'
    end

    # Admin Merchants: Top 5 Merchants by Revenue
    # As an admin,
    # When I visit the admin merchants index
    # Then I see the names of the top 5 merchants by total revenue generated
    # And I see that each merchant name links to the admin merchant show page for that merchant
    it 'lists the top 5 merchants by total revenue' do 
        Faker::UniqueGenerator.clear 

        # merchant_1 with $20 revenue 
        merchant_1 = Merchant.create!(name: Faker::Company.name)
        item_1 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 5)
        customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_1 = customer_1.invoices.create!(status: 1)
        ii_1a = invoice_1.invoice_items.create!(quantity: 4, unit_price: 5, status: 2, item_id: item_1.id)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_2 with $44 revenue 
        merchant_2 = Merchant.create!(name: Faker::Company.name)
        item_2a = merchant_2.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 10)
        item_2b = merchant_2.items.create!(name: 'water bottle2b', description: 'bottle of water', unit_price: 1)
        customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_2 = customer_2.invoices.create!(status: 1)
        ii_2a = invoice_2.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_2a.id)
        ii_2b = invoice_2.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_2b.id)
        transaction_2 = invoice_2.transactions.create!(credit_card_number: "1234", result: "success")
        
        # merchant_3 with $4 revenue 
        merchant_3 = Merchant.create!(name: Faker::Company.name)
        item_3 = merchant_3.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 1)
        customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_3 = customer_3.invoices.create!(status: 1)
        ii_3a = invoice_3.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_3.id)
        transaction_3 = invoice_3.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_4 with $30 revenue 
        merchant_4 = Merchant.create!(name: Faker::Company.name)
        item_4 = merchant_4.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 10)
        customer_4 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_4 = customer_4.invoices.create!(status: 1)
        ii_4a = invoice_4.invoice_items.create!(quantity: 3, unit_price: 10, status: 2, item_id: item_4.id)
        transaction_4 = invoice_4.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_5 with $70 revenue 
        merchant_5 = Merchant.create!(name: Faker::Company.name)
        item_5a = merchant_5.items.create!(name: 'water bottle5a', description: 'bottle of water', unit_price: 10)
        item_5b = merchant_5.items.create!(name: 'water bottle5b', description: 'bottle of water', unit_price: 5)
        customer_5 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_5 = customer_5.invoices.create!(status: 1)
        ii_5a = invoice_5.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_5a.id)
        ii_5b = invoice_5.invoice_items.create!(quantity: 6, unit_price: 5, status: 2, item_id: item_5b.id)
        transaction_5 = invoice_5.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_6 with $15 revenue 
        merchant_6 = Merchant.create!(name: Faker::Company.name)
        item_6a = merchant_6.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        item_6b = merchant_6.items.create!(name: 'water bottle6b', description: 'bottle of water', unit_price: 5)
        item_6c = merchant_6.items.create!(name: 'water bottle6c', description: 'bottle of water', unit_price: 7)
        customer_6 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_6 = customer_6.invoices.create!(status: 1)
        ii_6a = invoice_6.invoice_items.create!(quantity: 3, unit_price: 1, status: 2, item_id: item_6a.id)
        ii_6b = invoice_6.invoice_items.create!(quantity: 1, unit_price: 5, status: 2, item_id: item_6b.id)
        ii_6c = invoice_6.invoice_items.create!(quantity: 1, unit_price: 7, status: 2, item_id: item_6c.id)
        transaction_6 = invoice_6.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_7 with $0 revenue 
        merchant_7 = Merchant.create!(name: Faker::Company.name)
        item_7a = merchant_7.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        customer_7 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_7 = customer_7.invoices.create!(status: 1)
        ii_7a = invoice_7.invoice_items.create!(quantity: 100, unit_price: 1, status: 2, item_id: item_6a.id)
        transaction_7 = invoice_7.transactions.create!(credit_card_number: "1234", result: "failed")

        visit admin_merchants_path 

        within('#top-merchants-0') do 
            expect(page).to have_link(merchant_5.name)
        end

        within('#top-merchants-1') do 
            expect(page).to have_link(merchant_2.name)
        end

        within('#top-merchants-2') do 
            expect(page).to have_link(merchant_4.name)
        end

        within('#top-merchants-3') do 
            expect(page).to have_link(merchant_1.name)
        end

        within('#top-merchants-4') do 
            expect(page).to have_link(merchant_6.name)
            click_link merchant_6.name 
        end

        expect(current_path).to eq "/admin/merchants/#{merchant_6.id}"
    end

    # And I see the total revenue generated next to each merchant name
    # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    it 'shows total revenue next to each top merchant' do 
        Faker::UniqueGenerator.clear 

        # merchant_1 with $20 revenue 
        merchant_1 = Merchant.create!(name: Faker::Company.name)
        item_1 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 5)
        customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_1 = customer_1.invoices.create!(status: 1)
        ii_1a = invoice_1.invoice_items.create!(quantity: 4, unit_price: 5, status: 2, item_id: item_1.id)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_2 with $44 revenue 
        merchant_2 = Merchant.create!(name: Faker::Company.name)
        item_2a = merchant_2.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 10)
        item_2b = merchant_2.items.create!(name: 'water bottle2b', description: 'bottle of water', unit_price: 1)
        customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_2 = customer_2.invoices.create!(status: 1)
        ii_2a = invoice_2.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_2a.id)
        ii_2b = invoice_2.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_2b.id)
        transaction_2 = invoice_2.transactions.create!(credit_card_number: "1234", result: "success")
        
        # merchant_3 with $4 revenue 
        merchant_3 = Merchant.create!(name: Faker::Company.name)
        item_3 = merchant_3.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 1)
        customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_3 = customer_3.invoices.create!(status: 1)
        ii_3a = invoice_3.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_3.id)
        transaction_3 = invoice_3.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_4 with $30 revenue 
        merchant_4 = Merchant.create!(name: Faker::Company.name)
        item_4 = merchant_4.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 10)
        customer_4 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_4 = customer_4.invoices.create!(status: 1)
        ii_4a = invoice_4.invoice_items.create!(quantity: 3, unit_price: 10, status: 2, item_id: item_4.id)
        transaction_4 = invoice_4.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_5 with $70 revenue 
        merchant_5 = Merchant.create!(name: Faker::Company.name)
        item_5a = merchant_5.items.create!(name: 'water bottle5a', description: 'bottle of water', unit_price: 10)
        item_5b = merchant_5.items.create!(name: 'water bottle5b', description: 'bottle of water', unit_price: 5)
        customer_5 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_5 = customer_5.invoices.create!(status: 1)
        ii_5a = invoice_5.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_5a.id)
        ii_5b = invoice_5.invoice_items.create!(quantity: 6, unit_price: 5, status: 2, item_id: item_5b.id)
        transaction_5 = invoice_5.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_6 with $15 revenue 
        merchant_6 = Merchant.create!(name: Faker::Company.name)
        item_6a = merchant_6.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        item_6b = merchant_6.items.create!(name: 'water bottle6b', description: 'bottle of water', unit_price: 5)
        item_6c = merchant_6.items.create!(name: 'water bottle6c', description: 'bottle of water', unit_price: 7)
        customer_6 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_6 = customer_6.invoices.create!(status: 1)
        ii_6a = invoice_6.invoice_items.create!(quantity: 3, unit_price: 1, status: 2, item_id: item_6a.id)
        ii_6b = invoice_6.invoice_items.create!(quantity: 1, unit_price: 5, status: 2, item_id: item_6b.id)
        ii_6c = invoice_6.invoice_items.create!(quantity: 1, unit_price: 7, status: 2, item_id: item_6c.id)
        transaction_6 = invoice_6.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_7 with $0 revenue 
        merchant_7 = Merchant.create!(name: Faker::Company.name)
        item_7a = merchant_7.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        customer_7 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_7 = customer_7.invoices.create!(status: 1)
        ii_7a = invoice_7.invoice_items.create!(quantity: 100, unit_price: 1, status: 2, item_id: item_6a.id)
        transaction_7 = invoice_7.transactions.create!(credit_card_number: "1234", result: "failed")

        visit admin_merchants_path 

        within('#top-merchants-0') do 
            expect(page).to have_content("$70.00 in total sales")
        end

        within('#top-merchants-1') do 
            expect(page).to have_content("$44.00 in total sales")
        end

        within('#top-merchants-2') do 
            expect(page).to have_content("$30.00 in total sales")
        end

        within('#top-merchants-3') do 
            expect(page).to have_content("$20.00 in total sales")
        end

        within('#top-merchants-4') do 
            expect(page).to have_content("$15.00 in total sales")
        end
    end

    # Admin Merchants: Top Merchant's Best Day
    # As an admin,
    # When I visit the admin merchants index
    # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
    # And I see a label “Top selling date for <merchant name> was <date with most sales>"
    # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
    it 'displays the top selling date for each top merchant' do 
        Faker::UniqueGenerator.clear 

        # merchant_1 
        merchant_1 = Merchant.create!(name: Faker::Company.name)

        # invoice 1: $20 revenue, 11/24/2004 
        item_1 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 5)
        customer_1a = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2004, 11, 24, 1, 4, 44)
        time_2004 = Time.current 
        invoice_1a = customer_1a.invoices.create!(status: 1, created_at: time_2004)
        ii_1a = invoice_1a.invoice_items.create!(quantity: 4, unit_price: 5, status: 2, item_id: item_1.id)
        transaction_1a = invoice_1a.transactions.create!(credit_card_number: "1234", result: "success")

        # invoice 2: $44 revenue, 9/22/2020
        item_1b = merchant_1.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 10)
        item_1c = merchant_1.items.create!(name: 'water bottle2b', description: 'bottle of water', unit_price: 1)
        customer_1b = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2020, 9, 22, 1, 4, 44)
        time_2020 = Time.current
        invoice_1b = customer_1b.invoices.create!(status: 1, created_at: time_2020)
        ii_1b = invoice_1b.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_1b.id)
        ii_1c = invoice_1b.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_1c.id)
        transaction_1b = invoice_1b.transactions.create!(credit_card_number: "1234", result: "success")
        
        # invoice 3: $4 revenue, 1/1/2019
        item_1d = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 1)
        customer_1c = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2019, 1, 1, 1, 4, 44)
        time_2019 = Time.current
        invoice_1c = customer_1c.invoices.create!(status: 1, created_at: time_2019)
        ii_1d = invoice_1c.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_1d.id)
        transaction_1c = invoice_1c.transactions.create!(credit_card_number: "1234", result: "success")

        # invoice 4: $30 revenue, 4/5/2018
        item_1e = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 10)
        customer_1d = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2018, 4, 5, 1, 4, 44)
        time_2018 = Time.current
        invoice_1d = customer_1d.invoices.create!(status: 1, created_at: time_2018)
        ii_1e = invoice_1d.invoice_items.create!(quantity: 3, unit_price: 10, status: 2, item_id: item_1e.id)
        transaction_1d = invoice_1d.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_2
        merchant_2 = Merchant.create!(name: Faker::Company.name)

        # invoice 1: $80 revenue, 1/1/2022 
        item_2a = merchant_2.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 8)
        customer_2a = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2022, 1, 1, 1, 4, 44)
        time_2022 = Time.current 
        invoice_2a = customer_2a.invoices.create!(status: 1, created_at: time_2022)
        ii_2a = invoice_2a.invoice_items.create!(quantity: 10, unit_price: 8, status: 2, item_id: item_2a.id)
        transaction_2a = invoice_2a.transactions.create!(credit_card_number: "1234", result: "success")

        # invoice 2: $5 revenue, 1/1/2015
        item_2b = merchant_2.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 5)
        customer_2b = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2015, 1, 1, 1, 4, 44)
        time_2015 = Time.current
        invoice_2b = customer_2b.invoices.create!(status: 1, created_at: time_2015)
        ii_2b = invoice_2b.invoice_items.create!(quantity: 1, unit_price: 5, status: 2, item_id: item_2b.id)
        transaction_2b = invoice_2b.transactions.create!(credit_card_number: "1234", result: "success")

        visit admin_merchants_path 

        within('#top-merchants-0') do 
            expect(page).to have_content("Top day for #{merchant_1.name} was 9/22/20")
        end

        within('#top-merchants-1') do 
            expect(page).to have_content("Top day for #{merchant_2.name} was 1/1/22")
        end
    end
end