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

        click_link "Admin merchants page"

        expect(current_path).to eq('/admin/merchants')
      end

      it 'links to the admin invoices index' do
        visit admin_index_path

        click_link 'Admin invoices page'

        expect(current_path).to eq('/admin/invoices')
      end
    end
     
    describe 'the top 5 customers who have conducted largest number of succesful transactions' do
      xit 'lists the top 5 customers and number of successful transactions they have' do
        visit admin_index_path
        
        expect(page).to have_content("Top 5 Customers")
      end
    end

    describe 'I see a section for incomplete invoices' do
      describe 'I see a list of the ids of all invoices that have items that are not shipped' do
        describe 'And each invoice id links to that invoices admin show page' do
          it 'lists all invoices that have items that are not shipped' do
            visit admin_index_path

            expect(page).to have_content('Incomplete Invoices')
          end

          it 'links to the invoice admin show page for every invoice id shown' do
            customer_1 = Customer.create!(first_name: 'Sandy', last_name: 'Busch')
            customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Mann')
            customer_3 = Customer.create!(first_name: 'Miya', last_name: 'Yang')
            customer_4 = Customer.create!(first_name: 'Angel', last_name: 'Olsen')
            customer_5 = Customer.create!(first_name: 'Max', last_name: 'Smelter')

            invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 'completed')
            invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 'completed')
            invoice_3 = Invoice.create!(customer_id: customer_3.id, status: 'completed')
            invoice_4 = Invoice.create!(customer_id: customer_4.id, status: 'completed')
            invoice_5 = Invoice.create!(customer_id: customer_5.id, status: 'completed')

            merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
            merchant_2 = Merchant.create!(name: 'Bradley and Sons')

            item_1 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
            item_2 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
            item_3 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
            item_4 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_2.id)
            item_5 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_2.id)

            invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
            invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
            invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
            invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
            invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')
            
            visit admin_index_path

            expect(page).to have_content(invoice_item_2.invoice_id)
          end
        end
      end
    end
  end
end

# Admin Dashboard Incomplete Invoices

# As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page



# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted

