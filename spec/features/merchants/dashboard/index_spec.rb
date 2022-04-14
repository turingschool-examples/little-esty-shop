require 'rails_helper'
require 'time'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    @customer1 = Customer.create!(first_name: "John", last_name: "H")
    @invoice1 = @customer1.invoices.create!(status: "completed")
    @transactions_1a = @invoice1.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_1b = @invoice1.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_1c = @invoice1.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
    @transactions_1d = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

    @customer2 = Customer.create!(first_name: "Joseph", last_name: "D")
    @invoice2 = @customer2.invoices.create!(status: "completed")
    @transactions_2a = @invoice2.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_2b = @invoice2.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_2c = @invoice2.transactions.create!(credit_card_number: '1234567812345670', result: 'success')

    @customer3 = Customer.create!(first_name: "Ian", last_name: "R")
    @invoice3 = @customer3.invoices.create!(status: "completed")
    @transactions_3a = @invoice3.transactions.create!(credit_card_number: '1234567812345678', result: 'success')

    @customer4 = Customer.create!(first_name: "Loki", last_name: "R")
    @invoice4 = @customer4.invoices.create!(status: "completed")
    @transactions_4a = @invoice4.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_4b = @invoice4.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_4c = @invoice4.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
    @transactions_4d = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')
    @transactions_4e = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

    @customer5 = Customer.create!(first_name: "Amanda", last_name: "A")
    @invoice5 = @customer5.invoices.create!(status: "completed")
    @transactions_5a = @invoice5.transactions.create!(credit_card_number: '1234567812345678', result: 'failed')

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'has link to merchant item index' do
    within("#index-buttons") do
      click_button "Items Index"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end

  it 'has link to merchant invoices index' do
    click_button "Invoices Index"
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end

  it "merchant dashboard items ready to ship" do
    merchant_1 = Merchant.create!(name: "Pabu")
    item_1 = merchant_1.items.create!(name: "spoon", description: "stamped stainless steel, not deburred", unit_price: 80, status: 1, merchant_id: merchant_1.id)
    item_2 = merchant_1.items.create!(name: "fork", description: "stamped stainless steel, not deburred", unit_price: 90, status: 1, merchant_id: merchant_1.id)
    item_3 = merchant_1.items.create!(name: "butter knife", description: "stamped stainless steel, not deburred", unit_price: 65, status: 1, merchant_id: merchant_1.id)
    customer_1 = Customer.create(first_name: "Max", last_name: "Powers")
    customer_2 = Customer.create!(first_name: "Bob", last_name: "Ross")
    invoice_1 = customer_1.invoices.create!(status: 0)
    invoice_2 = customer_2.invoices.create!(status: 0)
    invoice_item_1 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_1.unit_price, status: 0, item_id: item_1.id)
    invoice_item_2 = invoice_2.invoice_items.create!(quantity: 12, unit_price: item_2.unit_price, status: 1, item_id: item_2.id)
    invoice_item_3 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_3.unit_price, status: 2, item_id: item_1.id)

    visit merchant_dashboard_index_path(merchant_1)

    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content(item_2.name)
    expect(page).not_to have_content(item_3.name) # Because item already shipped

    within ("#unshipped_invoice_item_#{invoice_item_1.id}") do
      expect(page).to have_content(invoice_item_1.invoice_id)
      expect(page).to have_content(item_1.name)
      expect(page).to have_link("#{invoice_1.id}")
      expect(page).to have_link(href: "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}/")
    end

    within ("#unshipped_invoice_item_#{invoice_item_2.id}") do
      expect(page).to have_content(invoice_item_2.invoice_id)
      expect(page).to have_content(item_2.name)
      expect(page).to have_link(href: "/merchants/#{merchant_1.id}/invoices/#{invoice_2.id}/")
    end

  end

  it "sorts invoices by least recent" do
    item_1 = @merchant1.items.create!(name: "spoon", description: "stamped stainless steel, not deburred", unit_price: 80, status: 1, merchant_id: @merchant1.id)
    item_2 = @merchant1.items.create!(name: "fork", description: "stamped stainless steel, not deburred", unit_price: 90, status: 1, merchant_id: @merchant1.id)
    item_3 = @merchant1.items.create!(name: "butter knife", description: "stamped stainless steel, not deburred", unit_price: 65, status: 1, merchant_id: @merchant1.id)
    customer_1 = Customer.create(first_name: "Max", last_name: "Powers")
    customer_2 = Customer.create!(first_name: "Bob", last_name: "Ross")
    invoice_1 = customer_1.invoices.create!(status: 0, created_at: Time.parse("2015.11.23"))
    invoice_2 = customer_2.invoices.create!(status: 0)
    invoice_item_1 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_1.unit_price, status: 0, item_id: item_1.id)
    invoice_item_2 = invoice_2.invoice_items.create!(quantity: 12, unit_price: item_2.unit_price, status: 1, item_id: item_2.id)
    invoice_item_3 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_3.unit_price, status: 1, item_id: item_3.id)

    visit merchant_dashboard_index_path(@merchant1)

    expect(item_3.name).to appear_before(item_2.name) # Invoice_1 items should appear first based on forced created_at date

    within ("#unshipped_invoice_item_#{invoice_item_1.id}") do
      expect(page).to have_content("Monday, November 23, 2015")
    end


  end

  it 'shows top 5 customers' do
    within("#top-customers") do
      expect("Loki").to appear_before("John")
      expect("John").to appear_before("Joseph")
      expect("Joseph").to appear_before("Ian")

      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.succsessful_transaction_count)
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer2.succsessful_transaction_count)
      expect(page).to have_content(@customer3.first_name)
      expect(page).to have_content(@customer3.succsessful_transaction_count)
      expect(page).to have_content(@customer4.first_name)
      expect(page).to have_content(@customer4.succsessful_transaction_count)
      expect(page).to_not have_content(@customer5.first_name)
    end
  end
end
