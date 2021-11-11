require 'rails_helper'

RSpec.describe 'admin dashboard show page' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)

    invoice1 = create(:invoice, customer: @customer1)
    invoice2 = create(:invoice, customer: @customer2)
    invoice3 = create(:invoice, customer: @customer3)
    invoice4 = create(:invoice, customer: @customer4)
    invoice5 = create(:invoice, customer: @customer5)
    invoice6 = create(:invoice, customer: @customer6)

    create_list(:transaction, 5, result: 'success', invoice: invoice1)
    create_list(:transaction, 4, result: 'success', invoice: invoice2)
    create_list(:transaction, 3, result: 'success', invoice: invoice3)
    create_list(:transaction, 2, result: 'success', invoice: invoice4)
    create(:transaction, result: 'success', invoice: invoice5)

    @completed_invoice = create(:invoice)
    @incomplete_invoice_1 = create(:invoice, created_at: '09/11/2001')
    @incomplete_invoice_2 = create(:invoice, created_at: '10/11/2001')

    invoice_item1 = create(:invoice_item, invoice: @completed_invoice, status: 2)
    invoice_item2 = create(:invoice_item, invoice: @incomplete_invoice_1, status: 0)
    invoice_item2 = create(:invoice_item, invoice: @incomplete_invoice_2, status: 1)

    visit "/admin/"
  end

  it 'has a link to admin merchants' do
    click_link("Merchants")

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'has a link to admin invoices' do
    click_link("Invoices")

    expect(current_path).to eq(admin_invoices_path)
  end

  it 'exists' do
  end

  it 'lists the top five customers' do
    within('#top-five-customers') do

      expect(@customer1.first_name).to appear_before(@customer2.first_name)
      expect(@customer2.first_name).to appear_before(@customer3.first_name)
      expect(@customer3.first_name).to appear_before(@customer4.first_name)
      expect(@customer4.first_name).to appear_before(@customer5.first_name)

      expect(page).to_not have_content(@customer6.first_name)
    end
  end

  it 'lists the incomplete_invoices' do

    within('#incomplete-invoices') do
      expect(page).to have_content(@incomplete_invoice_1.id)
      expect(page).to have_content(@incomplete_invoice_2.id)
      expect(page).to_not have_content(@completed_invoice.id)
    end
  end

  it 'orders incomplete_invoices oldest first and shows the date' do
    expect('Friday').to appear_before('Saturday')
  end
end
