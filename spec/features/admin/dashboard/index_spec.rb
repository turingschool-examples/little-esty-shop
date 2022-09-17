require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    @customer1 = Customer.create!(first_name: 'Gunther', last_name: 'Guyman')
    @customer2 = Customer.create!(first_name: 'Miles', last_name: 'Prower')
    @customer3 = Customer.create!(first_name: 'Mario', last_name: 'Mario')
    @customer4 = Customer.create!(first_name: 'Marneus', last_name: 'Calgar')
    @customer5 = Customer.create!(first_name: 'Sol', last_name: 'Badguy')
    @customer6 = Customer.create!(first_name: 'Wyatt', last_name: 'Kribs')

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2)
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 2)
    @invoice3 = Invoice.create!(customer_id: @customer2.id, status: 2)
    @invoice4 = Invoice.create!(customer_id: @customer3.id, status: 2)
    @invoice5 = Invoice.create!(customer_id: @customer4.id, status: 2)

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: 12345, result: 1)
    @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: 12345, result: 1)
    @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: 12345, result: 1)
    @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: 12345, result: 1)
    @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: 12345, result: 1)

    visit '/admin'
  end

  it "has a header letting you know it's the admin dash" do

    expect(page).to have_content("Admin Dashboard")
  end

  it "has links to the merchant and invoice index pages" do
    expect(page).to have_link("merchants")
    expect(page).to have_link("invoices")
  end

  it "has a working merchants index link" do
    click_link "merchants"
    expect(current_path).to eq("/admin/merchants")
  end

  xit "has a working invoices index link" do
    click_link "invoices"
    expect(current_path).to eq("/admin/invoices")
  end

  it "lists the top 5 customers by transaction" do
    expect(page).to have_content('Top 5 Customers')

    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)

    expect(page).to have_content(@customer2.first_name)
    expect(page).to have_content(@customer2.last_name)

    expect(page).to have_content(@customer3.first_name)
    expect(page).to have_content(@customer3.last_name)

    expect(page).to have_content(@customer4.first_name)
    expect(page).to have_content(@customer4.last_name)

    expect(page).to_not have_content(@customer5.first_name)
    expect(page).to_not have_content(@customer5.last_name)
  end

  it 'gives the number of transactions for each customer' do
    expect(page).to have_content(@customer1.number_of_transactions)
    expect(page).to have_content(@customer2.number_of_transactions)
    expect(page).to have_content(@customer3.number_of_transactions)
    expect(page).to have_content(@customer4.number_of_transactions)
  end
end
