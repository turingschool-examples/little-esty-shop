require 'rails_helper'

RSpec.describe 'Admin' do
  it 'it shows admin dashboard' do
    # Admin Dashboard

    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links' do
    # Admin Dashboard Links
    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a link to the admin merchants index (/admin/merchants)
    # And I see a link to the admin invoices index (/admin/invoices)
    visit '/admin'
    expect(page).to have_link('Merchants')
    click_link 'Merchants'
    expect(current_path).to eq('/admin/merchants')

    visit '/admin'
    expect(page).to have_link('Invoices')
    click_link 'Invoices'
    expect(current_path).to eq('/admin/invoices')
  end

  it "shows the top 5 customers" do
    # Admin Dashboard Statistics - Top Customers
    # As an admin,
    # When I visit the admin dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions
    # And next to each customer name I see the number of successful transactions they have
    # conducted
    @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
    @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
    @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
    @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
    @customer_5 = Customer.create!(first_name: "Brian", last_name: "Zanti")
    @customer_6 = Customer.create!(first_name: "Jamison", last_name: "Ordway")
    @customer_7 = Customer.create!(first_name: "Lawrence", last_name: "Whalen")

    @invoice_1 = @customer_1.invoices.create!(status: :in_progress)
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "1234 5678 1234 2678", credit_card_expiration_date: nil, result: :successful)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: :successful)
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "1234 4321 1234 4321", credit_card_expiration_date: nil, result: :successful)

    @invoice_2 = @customer_2.invoices.create!(status: :in_progress)
    @transaction_4 = @invoice_2.transactions.create!(credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: nil, result: :successful)
    @transaction_5 = @invoice_2.transactions.create!(credit_card_number: "4321 1234 4321 1234", credit_card_expiration_date: nil, result: :successful)

    @invoice_3 = @customer_3.invoices.create!(status: :in_progress)
    @transaction_6 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: :successful)

    @invoice_4 = @customer_4.invoices.create!(status: :in_progress)
    @transaction_7 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: :successful)
    @transaction_7 = @invoice_4.transactions.create!(credit_card_number: "7654 4567 7654 4567", credit_card_expiration_date: nil, result: :successful)

    @invoice_5 = @customer_5.invoices.create!(status: :in_progress)
    @transaction_8 = @invoice_5.transactions.create!(credit_card_number: "5432 2345 5432 2345", credit_card_expiration_date: nil, result: :successful)

    @invoice_6 = @customer_6.invoices.create!(status: :in_progress)
    @transaction_9 = @invoice_6.transactions.create!(credit_card_number: "6543 3456 6543 3456", credit_card_expiration_date: nil, result: :successful)

    visit '/admin'
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.invoices.transactions.count)
    expect(page).to have_content(@customer_2.name)
    expect(page).to have_content(@customer_3.name)
    expect(page).to have_content(@customer_4.name)
    expect(page).to have_content(@customer_5.name)
    expect(page).to_not have_content(@customer_6.name)

    expect(@customer_1.name).to appear_before(@customer_2)
    expect(@customer_2.name).to appear_before(@customer_3)
    expect(@customer_4.name).to appear_before(@customer_3)
    expect(@customer_3.name).to appear_before(@customer_5)
  end
end
