require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  it 'shows the name of the merchant' do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/admin/merchants/#{@merch1.id}"

    expect(page).to have_content('Name: Floopy Fopperations')
  end

  it 'can update the merchant' do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/admin/merchants/#{@merch1.id}"

    click_link('Update Merchant')

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}/edit")

    fill_in 'Name', with: 'Cherry Chidona'

    click_on('Save')

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}")

    expect(page).to have_content('Merchant has been successfully updated!')

    expect(page).to have_content('Name: Cherry Chidona')

    expect(page).to_not have_content('Name: Floopy Fopperations')
  end


    it 'shows the top customers of my merchant' do
      # As an admin,
      # When I visit the admin dashboard
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions
      # And next to each customer name I see the number of successful transactions they have
      # conducted with my merchant

      @merch1 = Merchant.create!(name: 'Floopy Fopperations')
      @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
      @item2 = @merch1.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)

      @cust1 = Customer.create!(first_name: "Mark", last_name: "Ruffalo")
      @cust2 = Customer.create!(first_name: "Jim", last_name: "Raddle")
      @cust3 = Customer.create!(first_name: "Bryan", last_name: "Cranston")
      @cust4 = Customer.create!(first_name: "Walter", last_name: "White")
      @cust5 = Customer.create!(first_name: "Hank", last_name: "Williams")
      @cust6 = Customer.create!(first_name: "Sammy", last_name: "Sosa")
      @cust7 = Customer.create!(first_name: "Barry", last_name: "Bonds")

      @inv1 = @cust1.invoices.create!(status: "in progress")
      @inv2 = @cust2.invoices.create!(status: "completed")
      @inv3 = @cust3.invoices.create!(status: "completed")
      @inv4 = @cust4.invoices.create!(status: "completed")
      @inv5 = @cust5.invoices.create!(status: "completed")
      @inv6 = @cust6.invoices.create!(status: "completed")
      @inv7 = @cust7.invoices.create!(status: "completed")

      InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv1.id}", quantity: 100, unit_price: 1000, status: 1)
      InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv2.id}", quantity: 200, unit_price: 2000, status: 1)
      InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv3.id}", quantity: 200, unit_price: 2000, status: 1)
      InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv4.id}", quantity: 200, unit_price: 2000, status: 1)
      InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv5.id}", quantity: 200, unit_price: 2000, status: 1)
      InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv6.id}", quantity: 200, unit_price: 2000, status: 1)
      InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv7.id}", quantity: 200, unit_price: 2000, status: 1)

      @inv1.transactions.create!(result: 0)
      @inv1.transactions.create!(result: 0)
      @inv1.transactions.create!(result: 0)

      @inv2.transactions.create!(result: 0)
      @inv2.transactions.create!(result: 0)
      @inv2.transactions.create!(result: 0)

      @inv3.transactions.create!(result: 0)
      @inv3.transactions.create!(result: 0)
      @inv3.transactions.create!(result: 0)

      @inv4.transactions.create!(result: 0)
      @inv4.transactions.create!(result: 0)
      @inv4.transactions.create!(result: 0)

      @inv5.transactions.create!(result: 0)
      @inv5.transactions.create!(result: 0)
      @inv5.transactions.create!(result: 0)
      @inv5.transactions.create!(result: 0)
      @inv5.transactions.create!(result: 0)

      @inv6.transactions.create!(result: 1)
      @inv6.transactions.create!(result: 1)
      @inv6.transactions.create!(result: 1)
      @inv6.transactions.create!(result: 1)

      @inv7.transactions.create!(result: 0)

      binding.pry

      #top 5 should be Hank Williams, then Mark, Jim, Bryan and Walter.  Sammy and Barry should not appear on this page

      visit "/admin/merchants/#{@merch1.id}"

      within "#top-5-customers" do
        expect(page).to have_content(@cust5.name)
        expect(page).to have_content("5 successful transactions")
        expect(page).to have_content(@cust1.name)
        expect(page).to have_content("3 successful transactions")
        expect(page).to have_content(@cust2.name)
        expect(page).to have_content("3 successful transactions")
        expect(page).to have_content(@cust3.name)
        expect(page).to have_content("3 successful transactions")
        expect(page).to have_content(@cust4.name)
        expect(page).to have_content("3 successful transactions")

        expect(page).to_not have_content(@cust6.name)
        expect(page).to_not have_content(@cust7.name)
      end

    end
end
