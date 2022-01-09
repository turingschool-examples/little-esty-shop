require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ron Swanson')
    @merchant_2 = Merchant.create!(name: 'Leslie Knope')
    @merchant_3 = Merchant.create!(name: 'Tom Haverford')
    @merchant_4 = Merchant.create!(name: 'April Ludgate')

    @item_1 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100, status: 0)
    @item_2 = @merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100, status: 0)
    @item_3 = @merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 0)
    @item_4 = @merchant_1.items.create!(name: "Gauges", description: "A thing around your neck", unit_price: 100, status: 1)
    @item_5 = @merchant_1.items.create!(name: "Plants", description: "A thing around your neck", unit_price: 100)
    @item_6 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_7 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_8 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_9 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_10 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_11 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_12 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_13 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_14 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_15 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_16 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_17 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_18 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_19 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
    @item_20 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)

    @customer_1 = Customer.create!(first_name: "Billy", last_name: "Joel")
    @customer_2 = Customer.create!(first_name: "Britney", last_name: "Spears")
    @customer_3 = Customer.create!(first_name: "Prince", last_name: "Mononym")
    @customer_4 = Customer.create!(first_name: "Garfunkle", last_name: "Oates")
    @customer_5 = Customer.create!(first_name: "Rick", last_name: "James")
    @customer_6 = Customer.create!(first_name: "Dave", last_name: "Chappelle")

    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
    @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')
    @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')
    @invoice_4 = @customer_4.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')
    @invoice_5 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')
    @invoice_6 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')
    @invoice_7 = @customer_3.invoices.create!(status: 1)
    @invoice_8 = @customer_4.invoices.create!(status: 1)
    @invoice_9 = @customer_1.invoices.create!(status: 1)
    @invoice_10 = @customer_1.invoices.create!(status: 1)
    @invoice_11 = @customer_3.invoices.create!(status: 1)
    @invoice_12 = @customer_3.invoices.create!(status: 1)
    @invoice_13 = @customer_4.invoices.create!(status: 1)
    @invoice_14 = @customer_4.invoices.create!(status: 1)
    @invoice_15 = @customer_5.invoices.create!(status: 1)
    @invoice_16 = @customer_5.invoices.create!(status: 1)
    @invoice_17 = @customer_5.invoices.create!(status: 1)
    @invoice_18 = @customer_5.invoices.create!(status: 1)
    @invoice_19 = @customer_5.invoices.create!(status: 1)
    @invoice_20 = @customer_6.invoices.create!(status: 1)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, status: 1)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_6.id, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_7.id, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_8.id, status: 2)
    @invoice_item_9 = InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_9.id, status: 2)
    @invoice_item_10 = InvoiceItem.create!(item_id: @item_10.id, invoice_id: @invoice_10.id, status: 2)
    @invoice_item_11 = InvoiceItem.create!(item_id: @item_11.id, invoice_id: @invoice_11.id, status: 2)
    @invoice_item_12 = InvoiceItem.create!(item_id: @item_12.id, invoice_id: @invoice_12.id, status: 2)
    @invoice_item_13 = InvoiceItem.create!(item_id: @item_13.id, invoice_id: @invoice_13.id, status: 2)
    @invoice_item_14 = InvoiceItem.create!(item_id: @item_14.id, invoice_id: @invoice_14.id, status: 2)
    @invoice_item_15 = InvoiceItem.create!(item_id: @item_15.id, invoice_id: @invoice_15.id, status: 2)
    @invoice_item_16 = InvoiceItem.create!(item_id: @item_16.id, invoice_id: @invoice_16.id, status: 2)
    @invoice_item_17 = InvoiceItem.create!(item_id: @item_17.id, invoice_id: @invoice_17.id, status: 2)
    @invoice_item_18 = InvoiceItem.create!(item_id: @item_18.id, invoice_id: @invoice_18.id, status: 2)
    @invoice_item_19 = InvoiceItem.create!(item_id: @item_19.id, invoice_id: @invoice_19.id, status: 2)
    @invoice_item_20 = InvoiceItem.create!(item_id: @item_20.id, invoice_id: @invoice_20.id, status: 2)

    @transaction_1 = @invoice_1.transactions.create!(result: 'success')
    @transaction_2 = @invoice_2.transactions.create!(result: 'success')
    @transaction_3 = @invoice_3.transactions.create!(result: 'success')
    @transaction_4 = @invoice_4.transactions.create!(result: 'success')
    @transaction_5 = @invoice_5.transactions.create!(result: 'success')
    @transaction_6 = @invoice_6.transactions.create!(result: 'success')
    @transaction_7 = @invoice_7.transactions.create!(result: 'success')
    @transaction_8 = @invoice_8.transactions.create!(result: 'success')
    @transaction_9 = @invoice_9.transactions.create!(result: 'success')
    @transaction_10 = @invoice_10.transactions.create!(result: 'success')
    @transaction_11 = @invoice_11.transactions.create!(result: 'success')
    @transaction_12 = @invoice_12.transactions.create!(result: 'success')
    @transaction_13 = @invoice_13.transactions.create!(result: 'success')
    @transaction_14 = @invoice_14.transactions.create!(result: 'success')
    @transaction_15 = @invoice_15.transactions.create!(result: 'success')
    @transaction_16 = @invoice_16.transactions.create!(result: 'success')
    @transaction_17 = @invoice_17.transactions.create!(result: 'success')
    @transaction_18 = @invoice_18.transactions.create!(result: 'success')
    @transaction_19 = @invoice_19.transactions.create!(result: 'success')
    @transaction_20 = @invoice_20.transactions.create!(result: 'success')

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  scenario 'visitor sees the name of my merchant' do
    expect(page).to have_content(@merchant_1.name)
  end

  scenario 'visitor sees link to merchant item index' do
    expect(page).to have_link("My items", href: merchant_items_path(@merchant_1.id))
  end

  scenario 'visitor sees link to merchant invoices index' do
    expect(page).to have_link("My invoices", href: merchant_invoices_path(@merchant_1.id))
  end

  scenario 'visitor sees top 5 customers associated with merchant' do
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to have_content(@customer_2.first_name)
    expect(page).to have_content(@customer_3.first_name)
    expect(page).to have_content(@customer_4.first_name)
    expect(page).to have_content(@customer_5.first_name)
    expect(page).to have_no_content(@customer_6.first_name)
  end

  scenario 'visitor sees number of successful transactions next to each customer' do
    within "#customer#{@merchant_1.top_5_customers.first.id}" do
      expect(page).to have_content(@merchant_1.top_5_customers.first.transaction_count)
    end

    within "#customer#{@merchant_1.top_5_customers[1].id}" do
      expect(page).to have_content(@merchant_1.top_5_customers[1].transaction_count)
    end

    within "#customer#{@merchant_1.top_5_customers[2].id}" do
      expect(page).to have_content(@merchant_1.top_5_customers[2].transaction_count)
    end

    within "#customer#{@merchant_1.top_5_customers[3].id}" do
      expect(page).to have_content(@merchant_1.top_5_customers[3].transaction_count)
    end

    within "#customer#{@merchant_1.top_5_customers[4].id}" do
      expect(page).to have_content(@merchant_1.top_5_customers[4].transaction_count)
    end
  end

  describe 'in items ready to ship section' do
    scenario 'visitor sees a list of item names that have not been shipped' do
      expect(page).to have_content("Items Ready to Ship")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_5.name)
    end

    scenario 'visitor sees the invoice id next to the item name' do

      expect(page).to have_link("#{@invoice_item_1.invoice_id}", href: merchant_invoice_path(@merchant_1.id, @invoice_1.id))
      expect(page).to have_link("#{@invoice_item_2.invoice_id}", href: merchant_invoice_path(@merchant_1.id, @invoice_2.id))
      expect(page).to have_link("#{@invoice_item_3.invoice_id}", href: merchant_invoice_path(@merchant_1.id, @invoice_3.id))
      expect(page).to have_link("#{@invoice_item_4.invoice_id}", href: merchant_invoice_path(@merchant_1.id, @invoice_4.id))
      expect(page).to have_link("#{@invoice_item_5.invoice_id}", href: merchant_invoice_path(@merchant_1.id, @invoice_5.id))
    end

    scenario 'visitor sees date of invoice creation next to each item' do
      expect(page).to have_content(@invoice_item_1.invoice_creation_date)
      expect(page).to have_content(@invoice_item_2.invoice_creation_date)
      expect(page).to have_content(@invoice_item_3.invoice_creation_date)
      expect(page).to have_content(@invoice_item_4.invoice_creation_date)
      expect(page).to have_content(@invoice_item_5.invoice_creation_date)
    end

    scenario 'visitor sees list ordered from oldest to newest' do
      first = find("#invoiceitem#{@invoice_item_1.id}")
      second = find("#invoiceitem#{@invoice_item_4.id}")
      third = find("#invoiceitem#{@invoice_item_5.id}")
      fourth = find("#invoiceitem#{@invoice_item_2.id}")
      fifth = find("#invoiceitem#{@invoice_item_3.id}")
      expect(first).to appear_before(second)
      expect(second).to appear_before(third)
      expect(third).to appear_before(fourth)
      expect(fourth).to appear_before(fifth)
    end
  end
end
