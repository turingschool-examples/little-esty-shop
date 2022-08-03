require 'rails_helper'

RSpec.describe 'Admin Invoice Index' do
   it "has a list of all invoice ids (As links) in the system" do
      merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
      merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
      item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

      customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
      customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
      customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
      customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
      customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
      customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')
      customer7 = Customer.create!(first_name: 'Not', last_name: 'Goodenough')

      invoice1 = customer1.invoices.create!(status: 2)
      invoice2 = customer1.invoices.create!(status: 2)
      invoice3 = customer2.invoices.create!(status: 2)
      invoice4 = customer2.invoices.create!(status: 2)
      invoice5 = customer2.invoices.create!(status: 2)

      visit "/admin/invoices"

      within "#invoice-#{invoice1.id}" do
         expect(page).to have_link("#{invoice1.id}")
      end

      within "#invoice-#{invoice2.id}" do
         expect(page).to have_link("#{invoice2.id}")
      end

      within "#invoice-#{invoice3.id}" do
         expect(page).to have_link("#{invoice3.id}")
      end

      within "#invoice-#{invoice4.id}" do
         expect(page).to have_link("#{invoice4.id}")
      end

      within "#invoice-#{invoice5.id}" do
         expect(page).to have_link("#{invoice5.id}")
         click_link("#{invoice5.id}")
         expect(current_path).to eq(admin_invoices_path(invoice5.id))
      end
   end
end


# As an admin,
# When I visit the admin Invoices index ("/admin/invoices")
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page
