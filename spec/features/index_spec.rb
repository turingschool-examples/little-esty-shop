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

            expect(page).to have_content('Invoices with items that are not yet shipped:')
          end

          it 'links to the invoice admin show page for every invoice id shown'
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

