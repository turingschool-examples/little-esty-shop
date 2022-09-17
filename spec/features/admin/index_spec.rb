require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  describe 'When I visit the admin dashboard' do
    describe 'I see a header indicating I am on the admin dashboard' do
      it 'has a header on the admin dashboard' do
        visit admin_index_path

        expect(page).to have_content("Admin Dashboard")
      end
    end

    describe 'I see a link to the admin merchants index and the admin invoices index' do
      it 'links to the admin merchants index' do
        visit admin_index_path

        click_button "Merchants"

        expect(current_path).to eq('/admin/merchants')
      end

      it 'links to the admin invoices index' do
        visit admin_index_path

        click_button 'Invoices'

        expect(current_path).to eq('/admin/invoices')
      end
    end
     
    describe 'the top 5 customers who have conducted largest number of succesful transactions' do
      it 'lists the top 5 customers and number of successful transactions they have' do
        7.times do
          Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
        end
        
        invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
        invoice_8 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
        invoice_13 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')

        invoice_9 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
        invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')

        invoice_10 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
        invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
        invoice_15 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')

        invoice_11 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
        invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')

        invoice_12 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')
        invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

        invoice_6 = Invoice.create!(customer_id: Customer.all[5].id, status: 'completed')

        invoice_7 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')
        invoice_14 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
        transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
        transaction_14 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )

        visit admin_index_path
        
        expect(page).to have_content("Top Customers")
        
        within "#customer-#{Customer.all[0].id}" do
          expect(page).to have_content("#{Customer.all[0].first_name} #{Customer.all[0].last_name} - 2 purchases")
          expect(page).to_not have_content("#{Customer.all[2].first_name}")
        end

        within "#customer-#{Customer.all[1].id}" do
          expect(page).to have_content("#{Customer.all[1].first_name} #{Customer.all[1].last_name} - 2 purchases")
          expect(page).to_not have_content("#{Customer.all[0].first_name}")
        end

        within "#customer-#{Customer.all[2].id}" do
          expect(page).to have_content("#{Customer.all[2].first_name} #{Customer.all[2].last_name} - 3 purchases")
        end
      end
    end

    describe 'I see a section for incomplete invoices' do
      describe 'I see a list of the ids of all invoices that have items that are not shipped' do
        describe 'And each invoice id links to that invoices admin show page' do
          it 'lists all invoices that have items that are not shipped' do
            5.times do
              Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
            end
            
            invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
            invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
            invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
            invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
            invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

            merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
            merchant_2 = Merchant.create!(name: 'Bradley and Sons')

            item_1 = Item.create!(name: 'Toe Ring', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
            item_2 = Item.create!(name: 'Strawberry Painting', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_1.id)
            item_3 = Item.create!(name: 'Gold ring', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
            item_4 = Item.create!(name: 'Silver Necklace', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 6), merchant_id: merchant_2.id)
            item_5 = Item.create!(name: 'Wooden spoon', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_2.id)

            invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
            invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
            invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
            invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
            invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')
            
            visit admin_index_path

            expect(page).to have_content('Incomplete Invoices')
            expect(page).to have_content(invoice_item_2.invoice_id)
            expect(page).to have_content(invoice_item_4.invoice_id)
            expect(page).to_not have_content(invoice_item_1.invoice_id)           
          end

          it 'links to the invoice admin show page for every invoice id shown' do
            customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Mann')       
            invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 'completed')
            merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
            item_2 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
            invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')

            visit admin_index_path

            click_link "#{invoice_item_2.invoice_id}"

            expect(current_path).to eq("/admin/invoices/#{invoice_item_2.invoice_id}")
          end
        end
      end
    end

    describe 'Next to each invoice id I see the date the invoice was created' do
      describe 'The list is ordered from oldest to newest' do
        it 'lists the date the invoice was created ordered from oldest to newest' do
          Customer.destroy_all
          Invoice.destroy_all
          Merchant.destroy_all
          InvoiceItem.destroy_all
          Item.destroy_all

          5.times do
            Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
          end

          invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed', created_at: Time.now - 3.days)
          invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed', created_at: Time.now - 1.days)
          invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed', created_at: Time.now - 2.days)
          invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed', created_at: Time.now)
          invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed', created_at: Time.now - 4.days)

          merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
          merchant_2 = Merchant.create!(name: 'Bradley and Sons')

          item_1 = Item.create!(name: 'Toe Ring', description: 'Ring for your toes', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
          item_2 = Item.create!(name: 'Strawberry Painting', description: 'Beautiful art', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_1.id)
          item_3 = Item.create!(name: 'Gold ring', description: 'Its gold!', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
          item_4 = Item.create!(name: 'Silver Necklace', description: 'Its silver!', unit_price: Faker::Number.number(digits: 6), merchant_id: merchant_2.id)
          item_5 = Item.create!(name: 'Wooden spoon', description: 'Made o wood', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_2.id)

          invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
          invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
          invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
          invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
          invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')

          visit admin_index_path

          expect(invoice_5.created_at.strftime('%A, %B %d, %Y')).to appear_before(invoice_2.created_at.strftime('%A, %B %d, %Y'))
          expect(invoice_2.created_at.strftime('%A, %B %d, %Y')).to appear_before(invoice_4.created_at.strftime('%A, %B %d, %Y'))
          expect(invoice_4.created_at.strftime('%A, %B %d, %Y')).to_not appear_before(invoice_5.created_at.strftime('%A, %B %d, %Y'))
          
          within "#invoice-#{invoice_2.id}" do
            expect(page).to have_content(invoice_2.created_at.strftime('%A, %B %d, %Y'))
          end

          within "#invoice-#{invoice_4.id}" do
            expect(page).to have_content(invoice_4.created_at.strftime('%A, %B %d, %Y'))
          end

          within "#invoice-#{invoice_5.id}" do
            expect(page).to have_content(invoice_5.created_at.strftime('%A, %B %d, %Y'))
          end
        end
      end
    end
# Admin Dashboard Invoices sorted by least recent

# As an admin,
# When I visit the admin dashboard
# In the section for "Incomplete Invoices",
# Next to each invoice id I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest
  end
end

