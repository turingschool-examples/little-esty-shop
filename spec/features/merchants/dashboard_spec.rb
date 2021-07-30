require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
  before :each do
    @merchant = Merchant.create!(name: 'Tom Holland')

    visit merchant_dashboard_index_path(@merchant.id)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant.id))
    expect(page).to have_content("Welcome #{@merchant.name}!")
    expect(page).to have_content("Dashboard")
  end

  it 'can take the user back to the merchants index' do
    click_link 'Return to Index'

    expect(current_path).to eq('/merchants')
  end

  it 'can take user to merchant items index page' do
    click_link 'Items'

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'can take user to merchant invoice index page' do
    click_link 'Invoices'

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end

  # As a merchant,
    # When I visit my merchant dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
  it "displays the top 5 customers for the merchant's dashboard" do
    @merchant = Merchant.create!(name: 'Lydia Rodarte-Quayle')
    @item = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant.id)

    @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
    @customer_1.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
    @customer_1.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

    @customer_2 = Customer.create!(first_name: 'Hector', last_name: 'Salamanca')
    @customer_2.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_2.invoices[0].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_2.invoices[1].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_2.invoices[2].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_2.invoices[3], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_2.invoices[3].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)

    @customer_3 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
    @customer_3.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_3.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_3.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_3.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_3.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_3.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_3.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_3.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_3.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

    @customer_4 = Customer.create!(first_name: 'Jesse', last_name: 'Pinkman')
    @customer_4.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_4.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_4.invoices[0].transactions.create!(credit_card_number: '3456', credit_card_expiration_date: '', result: 0)

    @customer_5 = Customer.create!(first_name: 'Walter', last_name: 'White')
    @customer_5.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_5.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_5.invoices[0].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
    @customer_5.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_5.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_5.invoices[1].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
    @customer_5.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_5.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_5.invoices[2].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
    @customer_5.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_5.invoices[3], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_5.invoices[3].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
    @customer_5.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_5.invoices[4], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
    @customer_5.invoices[4].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)

    @customer_6 = Customer.create!(first_name: 'Jack', last_name: 'Welker')
    @customer_7 = Customer.create!(first_name: 'Todd', last_name: 'Alquist')

    expected = Customer.top_customers_for_merchant(@merchant.id)
    # expected = [@customer_5, @customer_2, @customer_3, @customer_1, @customer_4]
    visit "/merchants/#{@merchant.id}/dashboard"
    # save_and_open_page

    within "#customer-table-headers" do
      expect(page).to have_content("Rank")
      expect(page).to have_content("Name")
      expect(page).to have_content("Total Purchases")
    end

    within "#top-customers" do
      expect("#{expected[0].first_name}").to appear_before("#{expected[1].first_name}")
      expect("#{expected[1].first_name}").to appear_before("#{expected[2].first_name}")
      expect("#{expected[3].first_name}").to appear_before("#{expected[4].first_name}")
    end

    within "#customer-#{expected[0].id}" do
      expect(page).to have_content("1")
      expect(page).to have_content("#{expected[0].first_name}")
      expect(page).to have_content("#{expected[0].last_name}")
      expect(page).to have_content("#{expected[0].transaction_count}")
    end

    within "#customer-#{expected[1].id}" do
      expect(page).to have_content("2")
      expect(page).to have_content("#{expected[1].first_name}")
      expect(page).to have_content("#{expected[1].last_name}")
      expect(page).to have_content("#{expected[1].transaction_count}")
    end

    within "#customer-#{expected[2].id}" do
      expect(page).to have_content("3")
      expect(page).to have_content("#{expected[2].first_name}")
      expect(page).to have_content("#{expected[2].last_name}")
      expect(page).to have_content("#{expected[2].transaction_count}")
    end

    within "#customer-#{expected[3].id}" do
      expect(page).to have_content("4")
      expect(page).to have_content("#{expected[3].first_name}")
      expect(page).to have_content("#{expected[3].last_name}")
      expect(page).to have_content("#{expected[3].transaction_count}")
    end

    within "#customer-#{expected[4].id}" do
      expect(page).to have_content("5")
      expect(page).to have_content("#{expected[4].first_name}")
      expect(page).to have_content("#{expected[4].last_name}")
      expect(page).to have_content("#{expected[4].transaction_count}")
    end

    expect(page).to_not have_content("#{@customer_6.first_name}")
    expect(page).to_not have_content("#{@customer_7.first_name}")
  end

  # As a merchant
    # When I visit my merchant dashboard
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page
    # In the section for "Items Ready to Ship",
      # Next to each Item name I see the date that the invoice was created
      # And I see the date formatted like "Monday, July 18, 2019"
      # And I see that the list is ordered from oldest to newest
  it "displays invoiced items ready to ship for the merchant's dashboard" do
    @merchant = Merchant.create!(name: 'Lydia Rodarte-Quayle')
    @item_1 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: '10 Gallon Drum', description: 'for storage', unit_price: 100, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Dolley', description: 'for transportation', unit_price: 10, merchant_id: @merchant.id)

    @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item_1, quantity: 1, unit_price: @item_1.unit_price, status: 1)
    @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item_2, quantity: 1, unit_price: @item_2.unit_price, status: 1)
    @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

    @customer_2 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item_1, quantity: 2, unit_price: @item_1.unit_price, status: 1)
    @customer_2.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item_2, quantity: 4, unit_price: @item_2.unit_price, status: 2)
    @customer_2.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 2)
    InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item_3, quantity: 1, unit_price: @item_3.unit_price, status: 1)
    @customer_2.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

    expected = Item.items_ready_to_ship_by_ordered_date(@merchant.id)
    # expect(expected[0].invoice_id).to eq(@customer_1.invoices[0].id)
    # expect(expected[1].invoice_id).to eq(@customer_1.invoices[1].id)
    # expect(expected[2].invoice_id).to eq(@customer_2.invoices[0].id)

    visit "/merchants/#{@merchant.id}/dashboard"
    # save_and_open_page

    within "#item-table-headers" do
      expect(page).to have_content("Item")
      expect(page).to have_content("Name")
      expect(page).to have_content("Invoice#")
      expect(page).to have_content("Transaction Date")
    end

    within "#item-#{expected[0].id}_#{expected[0].invoice_id}" do
      expect(page).to have_content("1")
      expect(page).to have_content("#{expected[0].name}")
      expect(page).to have_link("#{expected[0].invoice_id}")
      expect(page).to have_content("#{expected[0].format_date(expected[0].invoiced_date)}")
    end

    within "#item-#{expected[1].id}_#{expected[1].invoice_id}" do
      expect(page).to have_content("2")
      expect(page).to have_content("#{expected[1].name}")
      expect(page).to have_link("#{expected[1].invoice_id}")
      expect(page).to have_content("#{expected[1].format_date(expected[1].invoiced_date)}")
    end

    within "#item-#{expected[2].id}_#{expected[2].invoice_id}" do
      expect(page).to have_content("3")
      expect(page).to have_content("#{expected[2].name}")
      expect(page).to have_link("#{expected[2].invoice_id}")
      expect(page).to have_content("#{expected[2].format_date(expected[1].invoiced_date)}")
    end
  end

end
