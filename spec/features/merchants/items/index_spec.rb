require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ron Swanson')

    @item_1 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 900)
    @item_3 = @merchant_1.items.create!(name: "Earrings", description: "These go through your ears", unit_price: 1500)
    @item_4 = @merchant_1.items.create!(name: "Ring", description: "A thing around your finger", unit_price: 1000)
    @item_5 = @merchant_1.items.create!(name: "Toe Ring", description: "A thing around your neck", unit_price: 800)
    @item_6 = @merchant_1.items.create!(name: "Pendant", description: "A thing to put somewhere", unit_price: 1500)
    @item_7 = @merchant_1.items.create!(name: "Bandana", description: "Many uses", unit_price: 400)
    @item_8 = @merchant_1.items.create!(name: "Hair clip", description: "A thing to clip in your hair", unit_price: 500)

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

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1000, quantity: 1,  status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, unit_price: 900, quantity: 1, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, unit_price: 1500, quantity: 2,  status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: 1000, quantity: 3,  status: 1)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, unit_price: 1000, quantity: 1,  status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, unit_price: 900, quantity: 1, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_3.id, unit_price: 400, quantity: 36, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_3.id, unit_price: 500, quantity: 2, status: 2)
    @invoice_item_9 = InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_1.id, unit_price: 500, quantity: 2, status: 2)
    @invoice_item_10 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id, unit_price: 800, quantity: 1,status: 2)

    @transaction_1 = @invoice_1.transactions.create!(result: 'success')
    @transaction_2 = @invoice_2.transactions.create!(result: 'success')
    @transaction_3 = @invoice_3.transactions.create!(result: 'success')
    @transaction_4 = @invoice_1.transactions.create!(result: 'success')
    @transaction_5 = @invoice_2.transactions.create!(result: 'success')
    @transaction_6 = @invoice_3.transactions.create!(result: 'success')
    @transaction_7 = @invoice_1.transactions.create!(result: 'success')
    @transaction_8 = @invoice_2.transactions.create!(result: 'success')
    @transaction_9 = @invoice_3.transactions.create!(result: 'success')
    @transaction_10 = @invoice_3.transactions.create!(result: 'success')


    visit merchant_items_path(@merchant_1.id)
  end

  scenario 'visitor sees the name of all items of particular merchant as links' do
    expect(current_path).to eq(merchant_items_path(@merchant_1.id))

    within "#all_items-#{@merchant_1.id}" do
      expect(page).to have_link("#{@item_1.name}", href: merchant_item_path(@merchant_1.id, @item_1.id))
      expect(page).to have_link("#{@item_2.name}", href: merchant_item_path(@merchant_1.id, @item_2.id))
      expect(page).to have_link("#{@item_3.name}", href: merchant_item_path(@merchant_1.id, @item_3.id))
      expect(page).to have_link("#{@item_4.name}", href: merchant_item_path(@merchant_1.id, @item_4.id))
      expect(page).to have_link("#{@item_5.name}", href: merchant_item_path(@merchant_1.id, @item_5.id))
      expect(page).to have_link("#{@item_6.name}", href: merchant_item_path(@merchant_1.id, @item_6.id))
      expect(page).to have_link("#{@item_7.name}", href: merchant_item_path(@merchant_1.id, @item_7.id))
      expect(page).to have_link("#{@item_8.name}", href: merchant_item_path(@merchant_1.id, @item_8.id))
    end
  end

  scenario 'visitor sees the names of the top 5 most popular items ranked by total revenue generated' do
    expect(page).to have_content('Top 5 Items')
    first = find("#item#{@item_7.id}")
    second = find("#item#{@item_1.id}")
    third = find("#item#{@item_3.id}")
    fourth = find("#item#{@item_8.id}")
    fifth = find("#item#{@item_2.id}")
    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
    expect(third).to appear_before(fourth)
    expect(fourth).to appear_before(fifth)
  end

  scenario 'visitor sees that each item name in the top item list also links to that item show page' do
    within "#top_five_items-#{@merchant_1.id}" do
      expect(page).to have_link(@item_7.name)
      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_3.name)
      expect(page).to have_link(@item_8.name)
      expect(page).to have_link(@item_2.name)
    end
  end

  scenario 'visitor sees the total revenue generated next to each item name' do
    within "#top_five_items-#{@merchant_1.id}" do
      expect(page).to have_content(@merchant_1.top_five_items[0].total_revenue)
      expect(page).to have_content(@merchant_1.top_five_items[1].total_revenue)
      expect(page).to have_content(@merchant_1.top_five_items[2].total_revenue)
      expect(page).to have_content(@merchant_1.top_five_items[3].total_revenue)
      expect(page).to have_content(@merchant_1.top_five_items[4].total_revenue)
    end
  end

scenario 'vistor sees date with most sales next to top five most popular items' do
    within "#top_five_items-#{@merchant_1.id}" do
      expect(page).to have_content(@merchant_1.top_five_items[0].date_with_most_sales)
      expect(page).to have_content(@merchant_1.top_five_items[1].date_with_most_sales)
      expect(page).to have_content(@merchant_1.top_five_items[2].date_with_most_sales)
      expect(page).to have_content(@merchant_1.top_five_items[3].date_with_most_sales)
      expect(page).to have_content(@merchant_1.top_five_items[4].date_with_most_sales)
    end
  end
end
