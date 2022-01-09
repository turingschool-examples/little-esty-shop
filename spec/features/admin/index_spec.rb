require 'rails_helper'

RSpec.describe 'admin index page' do
  before(:each) do
  end
  it "has a header indicating you are on the admin dashboard" do
    # merchant_1 = Merchant.create!(name: 'merchant_1')
    # merchant_2 = Merchant.create!(name: 'merchant_2')
    # customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    # invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    # invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    # invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
    # item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    # item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    # item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    # invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    # invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    # invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it "has links to admin merchants and invoices index" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'

    expect(page).to have_link('Merchants')
    expect(page).to have_link('Invoices')
  end

  it "has a section for all incomplete invoices id's" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'

    expect(page).to_not have_content(invoice_2.id)
    expect(page).to have_link(invoice_1.id)
    expect(page).to have_link(invoice_3.id)
    click_link(invoice_1.id)
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end

  it "orders incomplete invoices from oldest to newest with date" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2012-03-25 09:54:09 UTC")
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2012-03-24 15:54:10 UTC")
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2012-03-06 21:54:10 UTC")
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 1)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)

    visit '/admin'
    expect("#{invoice_3.id}").to appear_before("#{invoice_2.id}")
    expect("#{invoice_2.id}").to appear_before("#{invoice_1.id}")
  end

  it 'I see the names of the top 5 customers who have conducted successful transactions' do
    merchant_1 = create(:merchant)
    item = create(:item, merchant_id: merchant_1.id)
    # customer_1, 6 succesful transactions and 1 failed
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id, status: 2)
    transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
    failed_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
    # customer_2 5 succesful transactions
    customer_2 = create(:customer)
    invoice_2 = create(:invoice, customer_id: customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id, status: 2)
    transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
    #customer_3 4 succesful
    customer_3 = create(:customer)
    invoice_3 = create(:invoice, customer_id: customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id, status: 2)
    transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
    #customer_4 3 succesful
    customer_4 = create(:customer)
    invoice_4 = create(:invoice, customer_id: customer_4.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id, status: 2)
    transactions_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
    #customer_5 2 succesful
    customer_5 = create(:customer)
    invoice_5 = create(:invoice, customer_id: customer_5.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id, status: 2)
    transactions_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)
    #customer_6 1 succesful
    customer_6 = create(:customer)
    invoice_6 = create(:invoice, customer_id: customer_6.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id, status: 2)
    transactions_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
    visit '/admin'

    within"#top_five_customers" do
      expect(page).to have_content("Name: #{customer_1.full_name} - 6")
      expect(page).to have_content("Name: #{customer_2.full_name} - 5")
      expect(page).to have_content("Name: #{customer_3.full_name} - 4")
      expect(page).to have_content("Name: #{customer_4.full_name} - 3")
      expect(page).to have_content("Name: #{customer_5.full_name} - 2")
      expect(customer_1.full_name).to appear_before(customer_2.full_name)
      expect(customer_2.full_name).to appear_before(customer_3.full_name)
      expect(customer_3.full_name).to appear_before(customer_4.full_name)
      expect(customer_4.full_name).to appear_before(customer_5.full_name)
      expect(page).to have_content(customer_5.full_name)
      expect(page).to_not have_content(customer_6.full_name)
    end
  end

end
