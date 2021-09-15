require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @customer1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Steve', last_name: 'Dobson')
    @customer3 = Customer.create!(first_name: 'Melenie', last_name: 'Kelly')
    @customer4 = Customer.create!(first_name: 'Rachel', last_name: 'Jonas')
    @customer5 = Customer.create!(first_name: 'Adam', last_name: 'Tally')
    @customer6 = Customer.create!(first_name: 'George', last_name: 'Bratz')
  end

  describe 'Admin Dashboard' do
    xit 'indicates the page is admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
    end

    xit 'shows links to merchants index & invoices index' do
      visit '/admin'

      expect(page).to have_link('List of Merchants')
      expect(page).to have_link('List of Invoices')
    end


    xit 'can display the names of the top 5 customers' do
      visit '/admin'
    end
  end
end
