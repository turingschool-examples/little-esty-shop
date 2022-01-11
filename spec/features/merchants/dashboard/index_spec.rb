require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @merchant2 = FactoryBot.create(:merchant)

    @item = FactoryBot.create(:item, merchant: @merchant)
    @item2 = FactoryBot.create(:item, merchant: @merchant)
    @item3 = FactoryBot.create(:item, merchant: @merchant)
    @item4 = FactoryBot.create(:item, merchant: @merchant)
    @item5 = FactoryBot.create(:item, merchant: @merchant)
    # edge case
    @item6 = FactoryBot.create(:item, merchant: @merchant2)

    @customer_1 = FactoryBot.create(:customer)
    @customer_2 = FactoryBot.create(:customer)
    @customer_3 = FactoryBot.create(:customer)
    @customer_4 = FactoryBot.create(:customer)
    @customer_5 = FactoryBot.create(:customer)
    @customer_6 = FactoryBot.create(:customer)

    @invoice_1 = FactoryBot.create(:invoice, customer: @customer_1, status: "in progress", created_at: "Sun, 09 Jan 2022 01:18:59 UTC +00:00")
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer_2, status: "in progress", created_at: "Sun, 09 Jan 2022 01:19:59 UTC +00:00")
    @invoice_3 = FactoryBot.create(:invoice, customer: @customer_3, status: "in progress", created_at: "Sun, 09 Jan 2022 01:20:59 UTC +00:00")
    @invoice_4 = FactoryBot.create(:invoice, customer: @customer_4, status: "in progress", created_at: "Sun, 09 Jan 2022 01:21:59 UTC +00:00")
    @invoice_5 = FactoryBot.create(:invoice, customer: @customer_5, status: "in progress", created_at: "Sun, 09 Jan 2022 01:22:59 UTC +00:00")

    @transaction_1 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_3 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")

    @transaction_4 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_5 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_6 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_7 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_8 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")

    @transaction_9 = FactoryBot.create(:transaction, invoice: @invoice_3, result: "success")

    @transaction_10 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_11 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_12 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_13 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")

    @transaction_14 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_15 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_16 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "failed")

    @invoice_item_1 = FactoryBot.create(:invoice_item, invoice: @invoice_1, item: @item, status: "pending")
    @invoice_item_2 = FactoryBot.create(:invoice_item, invoice: @invoice_2, item: @item2, status: "pending")
    @invoice_item_3 = FactoryBot.create(:invoice_item, invoice: @invoice_3, item: @item3, status: "packaged")
    @invoice_item_4 = FactoryBot.create(:invoice_item, invoice: @invoice_4, item: @item4, status: "packaged")
    @invoice_item_5 = FactoryBot.create(:invoice_item, invoice: @invoice_5, item: @item5, status: "packaged")

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'shows the merchants name' do
    expect(page).to have_content(@merchant.name)
  end

  it 'links to merchant items index' do
    click_link("Items")
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'links to merchant invoices index' do
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end


  it 'shows the names of the top 5 customers' do
    expect(@customer_2.first_name).to appear_before(@customer_4.first_name)
    expect(@customer_4.first_name).to appear_before(@customer_1.first_name)
    expect(@customer_1.first_name).to appear_before(@customer_5.first_name)
    expect(@customer_5.first_name).to appear_before(@customer_3.first_name)

    expect(page).to_not have_content(@customer_6.last_name)
  end

  it 'shows the number of successful transactions they have conducted with the merchant' do
    within "#customer-#{@customer_2.first_name}" do
      expect(page).to have_content(5)
    end

    within "#customer-#{@customer_4.first_name}" do
      expect(page).to have_content(4)
    end

    within "#customer-#{@customer_1.first_name}" do
      expect(page).to have_content(3)
    end

    within "#customer-#{@customer_5.first_name}" do
      expect(page).to have_content(2)
    end

    within "#customer-#{@customer_3.first_name}" do
      expect(page).to have_content(1)
    end
  end

  it 'has a section for Items Ready to Ship' do
    expect(page).to have_content("Items Ready To Ship")
  end

  it 'lists the item names of those that have been ordered but not shipped'  do # with the invoice id, as a link, next to them'
    within "#merchants-item-#{@item3.name}" do
      expect(page).to have_content(@item3.name)

      expect(page).to_not have_content(@item4.name)
      expect(page).to_not have_content(@item5.name)
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item6.name)
    end

    within "#merchants-item-#{@item4.name}" do
      expect(page).to have_content(@item4.name)

      expect(page).to_not have_content(@item3.name)
      expect(page).to_not have_content(@item5.name)
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item6.name)
    end

    within "#merchants-item-#{@item5.name}" do
      expect(page).to have_content(@item5.name)

      expect(page).to_not have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item6.name)
    end
  end

  it 'has the invoice id as a link next to the item name' do
    within "#merchants-item-#{@item3.name}" do
      expect(page).to have_content(@item3.invoices.first.id)
      expect(page).to have_link("#{@item3.invoices.first.id}", href: "/merchants/#{@merchant.id}/invoices/#{@item3.invoices.first.id}")
    end

    within "#merchants-item-#{@item4.name}" do
      expect(page).to have_content(@item4.invoices.first.id)
      expect(page).to have_link("#{@item4.invoices.first.id}", href: "/merchants/#{@merchant.id}/invoices/#{@item4.invoices.first.id}")
    end

    within "#merchants-item-#{@item5.name}" do
      expect(page).to have_content(@item5.invoices.first.id)
      expect(page).to have_link("#{@item5.invoices.first.id}", href: "/merchants/#{@merchant.id}/invoices/#{@item5.invoices.first.id}")
    end
  end

  it 'has the date of the invoice creation next to each item' do
    within "#merchants-item-#{@item3.name}" do
      expect(page).to have_content(@item3.invoices.first.created_at.strftime("%A, %B %-d, %Y"))
    end

    within "#merchants-item-#{@item4.name}" do
      expect(page).to have_content(@item4.invoices.first.created_at.strftime("%A, %B %-d, %Y"))
    end

    within "#merchants-item-#{@item5.name}" do
      expect(page).to have_content(@item5.invoices.first.created_at.strftime("%A, %B %-d, %Y"))
    end
  end

  it 'lists the items from oldest to newest by invoice' do
    expect(@item3.name).to appear_before(@item4.name)
    expect(@item4.name).to appear_before(@item5.name)
  end
end
