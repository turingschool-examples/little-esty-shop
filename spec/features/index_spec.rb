require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  describe 'When I visit the admin dashboard' do
    describe 'I see a header indicating I am on the admin dashboard' do
      it 'has a header on the admin dashboard' do
        visit admin_index_path

        expect(page).to have_content("Welcome to the Admin Dashboard")
      end
    end

    describe 'the top 5 customers who have conducted largest number of succesful transactions' do
      xit 'lists the top 5 customers and number of successful transactions they have' do
        visit admin_index_path
        
        expect(page).to have_content("Top 5 Customers")
      end
    end

    describe 'I see a link to the admin merchants index and the admin invoices index' do
      it 'links to the admin merchants and admin invoices index' do
        visit admin_index_path

        expect(page).to have_link('Admin merchant page')
        expect(page).to have_link('Admin invoices page')
      end
    end
  end
end

# Admin Dashboard Links

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)



# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted

Customer.distinct.select("customers.*").joins(invoices: :transactions).order('transactions.count').where("transactions.result" => 1).limit(5)